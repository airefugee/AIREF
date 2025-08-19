// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title AIRefugeeToken Enhanced
 * @dev AI Refugee Meme Coin with full functionality including DAO governance interface
 * @author AI Refugee Team
 */
contract AIRefugeeTokenEnhanced is 
    ERC20Upgradeable, 
    ERC20BurnableUpgradeable, 
    PausableUpgradeable, 
    OwnableUpgradeable, 
    UUPSUpgradeable 
{
    uint256 public constant INITIAL_SUPPLY = 120_000_000_000 * 1e18;
    
    // 黑名单
    mapping(address => bool) public blacklist;
    
    // DAO 治理状态
    bool public governanceEnabled;
    address public governance;
    
    // 治理参数
    struct GovernanceParams {
        uint256 votingPeriod;       // 投票周期
        uint256 proposalThreshold;  // 提案门槛
        uint256 quorum;            // 法定人数
        bool active;               // 是否激活
    }
    
    GovernanceParams public governanceParams;
    
    // 紧急状态
    bool public emergencyStop;
    
    // 事件
    event AddedToBlacklist(address indexed account);
    event RemovedFromBlacklist(address indexed account);
    event TokensRecovered(address indexed token, address indexed to, uint256 amount);
    event GovernanceEnabled(address indexed governance);
    event GovernanceDisabled();
    event GovernanceParamsUpdated(uint256 votingPeriod, uint256 proposalThreshold, uint256 quorum);
    event EmergencyStopActivated();
    event EmergencyStopDeactivated();
    event ContractUpgraded(address indexed implementation);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address owner_) public initializer {
        __ERC20_init("AI Refugee Meme Coin", "AIREF");
        __ERC20Burnable_init();
        __Pausable_init();
        __Ownable_init(owner_);
        __UUPSUpgradeable_init();
        _mint(owner_, INITIAL_SUPPLY);
        
        // 初始化治理参数
        governanceParams = GovernanceParams({
            votingPeriod: 7 days,
            proposalThreshold: 100000 * 1e18, // 10万代币提案门槛
            quorum: 500000 * 1e18,            // 50万代币法定人数
            active: false
        });
    }

    // ========== 黑名单管理 ==========
    
    function addToBlacklist(address account) external onlyOwnerOrGovernance {
        blacklist[account] = true;
        emit AddedToBlacklist(account);
    }

    function removeFromBlacklist(address account) external onlyOwnerOrGovernance {
        blacklist[account] = false;
        emit RemovedFromBlacklist(account);
    }

    function addMultipleToBlacklist(address[] calldata accounts) external onlyOwnerOrGovernance {
        for (uint256 i = 0; i < accounts.length; i++) {
            blacklist[accounts[i]] = true;
            emit AddedToBlacklist(accounts[i]);
        }
    }
    
    function isBlacklisted(address account) external view returns (bool) {
        return blacklist[account];
    }

    // ========== 暂停功能 ==========
    
    function pause() external onlyOwnerOrGovernance {
        _pause();
    }

    function unpause() external onlyOwnerOrGovernance {
        _unpause();
    }
    
    // 紧急停机
    function emergencyPause() external onlyOwner {
        emergencyStop = true;
        _pause();
        emit EmergencyStopActivated();
    }
    
    function emergencyUnpause() external onlyOwner {
        emergencyStop = false;
        _unpause();
        emit EmergencyStopDeactivated();
    }    // ========== 代币回收 ==========
    
    function recoverTokens(address token, address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Cannot recover to zero address");
        require(amount > 0, "Amount must be greater than 0");
        
        if (token == address(0)) {
            require(address(this).balance >= amount, "Insufficient ETH balance");
            payable(to).transfer(amount);
        } else {
            require(IERC20(token).transfer(to, amount), "Token transfer failed");
        }
        emit TokensRecovered(token, to, amount);
    }
    
    // 回收 ETH
    function recoverETH(address payable to, uint256 amount) external onlyOwner {
        require(to != address(0), "Cannot recover to zero address");
        require(amount > 0, "Amount must be greater than 0");
        require(address(this).balance >= amount, "Insufficient ETH balance");
        to.transfer(amount);
        emit TokensRecovered(address(0), to, amount);
    }

    // ========== DAO 治理接口预留 ==========
    
    function enableGovernance(address _governance) external onlyOwner {
        require(_governance != address(0), "Invalid governance address");
        require(!governanceEnabled, "Governance already enabled");
        
        governance = _governance;
        governanceEnabled = true;
        governanceParams.active = true;
        
        emit GovernanceEnabled(_governance);
    }
    
    function disableGovernance() external onlyOwner {
        require(governanceEnabled, "Governance not enabled");
        
        governance = address(0);
        governanceEnabled = false;
        governanceParams.active = false;
        
        emit GovernanceDisabled();
    }
    
    function updateGovernanceParams(
        uint256 _votingPeriod,
        uint256 _proposalThreshold,
        uint256 _quorum
    ) external onlyOwnerOrGovernance {
        require(_votingPeriod > 0, "Invalid voting period");
        require(_proposalThreshold > 0, "Invalid proposal threshold");
        require(_quorum > 0, "Invalid quorum");
        
        governanceParams.votingPeriod = _votingPeriod;
        governanceParams.proposalThreshold = _proposalThreshold;
        governanceParams.quorum = _quorum;
        
        emit GovernanceParamsUpdated(_votingPeriod, _proposalThreshold, _quorum);
    }
    
    // 治理执行接口（预留给治理合约调用）
    function governanceExecute(bytes calldata data) external onlyGovernance returns (bool success, bytes memory returnData) {
        require(governanceEnabled, "Governance not enabled");
        (success, returnData) = address(this).call(data);
    }

    // ========== 管理功能 ==========
    
    // 铸造功能（仅限管理员或治理）
    function mint(address to, uint256 amount) external onlyOwnerOrGovernance {
        _mint(to, amount);
    }
    
    // 批量转账（管理员功能）
    function batchTransfer(address[] calldata recipients, uint256[] calldata amounts) external onlyOwnerOrGovernance {
        require(recipients.length == amounts.length, "Arrays length mismatch");
        
        for (uint256 i = 0; i < recipients.length; i++) {
            _transfer(_msgSender(), recipients[i], amounts[i]);
        }
    }

    // ========== 查询功能 ==========
    
    function getGovernanceInfo() external view returns (
        bool enabled,
        address governanceAddress,
        GovernanceParams memory params
    ) {
        return (governanceEnabled, governance, governanceParams);
    }
    
    function isEmergencyStopped() external view returns (bool) {
        return emergencyStop;
    }

    // ========== 内部函数 ==========
    
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        require(!emergencyStop, "Emergency stop activated");
        require(!blacklist[from], "AIRefugeeToken: sender is blacklisted");
        require(!blacklist[to], "AIRefugeeToken: recipient is blacklisted");
        super._update(from, to, amount);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwnerOrGovernance {
        emit ContractUpgraded(newImplementation);
    }

    // ========== 修饰符 ==========
    
    modifier onlyOwnerOrGovernance() {
        require(
            _msgSender() == owner() || 
            (governanceEnabled && _msgSender() == governance),
            "Caller is not owner or governance"
        );
        _;
    }
    
    modifier onlyGovernance() {
        require(governanceEnabled && _msgSender() == governance, "Caller is not governance");
        _;
    }

    // ========== 接收 ETH ==========
    
    receive() external payable {
        // 允许接收 ETH（用于回收功能）
    }
}
