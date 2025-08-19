<!-- This README provides detailed information about the AIREF (AI Refugee Meme Coin) project. It explains the purpose of the token, summarizes key contract parameters from the verified BSC deployment, outlines tokenomics, and offers guidance on contributing and participating in the community. Citations reference the BscScan overview and the open‑source contract on GitHub to help developers verify the statements. -->
🌐 AI Refugee Meme Coin (AIREF)

AIREF (AI Refugee Meme Coin) 是一个以社区为驱动、面向未来的去中心化代币，
旨在为因人工智能和自动化浪潮而面临工作不稳定或失业的群体打造一个数字家园。
通过区块链透明度、DAO 治理和 NFT 激励机制，我们希望凝聚社区力量，推动关注
人文关怀与科技平衡的公共讨论。

合约已完全开源并在 BSC 主网部署成功：

GitHub 源码仓库: airefugee/AIREF

BscScan 合约地址: 0xCDE96Ce64B88Acf50aCeCa4E87c2EC85c74ee190

📜 合约信息
| 属性               | 内容                                    | 说明                                                       |
| ---------------- | ------------------------------------- | -------------------------------------------------------- |
| **Token Name**   | **AI Refugee Meme Coin**              | 合约初始化函数调用了 `__ERC20_init` 并将名称设置为 “AI Refugee Meme Coin” |
| **Symbol**       | **AIREF**                             | 同样在初始化函数中设置为 “AIREF”                                     |
| **Standard**     | **BEP‑20 / ERC20 Upgradeable**        | 使用 OpenZeppelin 的可升级 ERC20 模板构建                          |
| **Blockchain**   | **Binance Smart Chain (BSC) Mainnet** | 部署在 BSC 主网并通过验证                                          |
| **Decimals**     | **18**                                | BscScan 的 “Other Info” 部分显示合约具有 18 位小数                   |
| **Total Supply** | **120,000,000,000 AIREF**             | BscScan 概览面板指出最大总供应为 120 亿 AIREF                         |
| **License**      | **MIT**                               | 仓库包含 MIT 许可证，允许自由复制、修改和分发                                |


🚀 特色功能

DAO 去中心化治理 — 通过治理投票调整社区政策、提案参数和黑名单等；合约内置治理参数结构体并支持启用/禁用治理。

可升级性 & 可暂停性 — 采用 OpenZeppelin UUPS 升级模式和可暂停机制，未来可安全升级合约或启用应急停止；同时支持黑名单和紧急停止功能。

NFT 与 Meme 文化结合 — 代币旨在支持周边的 NFT 和 Meme 社区活动，让“AI 难民”拥有共同身份和故事。

多链兼容 — 代码基于 ERC20 Upgradeable，未来可轻松扩展到其他 EVM 链。

透明公开 — 合约开源且已在 BSC 上通过主网校验，可直接在 BscScan 上查看源码、交易和持币地址列表。

📊 代币经济模型 (Tokenomics)

总供应固定，所有分配公开记录在链上。以下分配比例旨在支持社区建设、流动性和长期发展：

| 分配方向                | 占比  | 用途简述                      |
| ------------------- | --- | ------------------------- |
| **社区空投 & 激励**       | 30% | 奖励早期支持者、社区活动和贡献者          |
| **DEX 流动性池**        | 25% | 在 PancakeSwap 等 DEX 添加流动性 |
| **团队储备**            | 15% | 项目开发和长期运营锁仓，按计划解锁         |
| **合作伙伴 / DAO 基金**   | 10% | 战略合作与治理提案资金               |
| **NFT & GameFi 激励** | 10% | 未来 NFT 生态、游戏奖励            |
| **市场推广**            | 10% | 社区增长、跨链拓展、品牌传播            |


📂 项目结构

├── AIRefugeeTokenEnhanced.sol   # 主合约，基于 ERC20Upgradeable，包含治理和黑名单功能

├── LICENSE                      # MIT 开源协议

└── README.md                    # 项目说明文档


🔧 部署与验证

合约 AIRefugeeTokenEnhanced.sol 已部署在 Binance Smart Chain 主网，对应地址为0xCDE96Ce64B88Acf50aCeCa4E87c2EC85c74ee190。BscScan 显示该合约已验证，具有18位小数并定义的总供应为 1200 亿 AIREF。您可以在 BscScan 上查看
源代码、交易历史和持币分布，也可以使用 Remix 等工具对合约函数进行调用。https://bscscan.com/address/0xCDE96Ce64B88Acf50aCeCa4E87c2EC85c74ee190

安装自定义代币到钱包:

在 MetaMask 或 TrustWallet 中添加 AIREF：

打开钱包，选择 “添加代币/自定义代币”。

输入合约地址：0xCDE96Ce64B88Acf50aCeCa4E87c2EC85c74ee190。

网络选择 Binance Smart Chain (BSC)。

代币符号将自动填写为 AIREF，小数位数为 18。

确认后即可查看和接收 AIREF 代币。

获取 AIREF

社区空投 & 活动 — 关注官方 Twitter、Discord 和 Telegram，参加空投、竞赛和创意活动。

DEX 交易 — 上线 PancakeSwap 等 DEX 后，可用 BNB 或 BUSD 与 AIREF 进行兑换。

贡献换取 — 开源社区贡献代码、设计或宣传也可获得一定额度的 AIREF 奖励。

🤝 贡献指南 (Contributing Guide)

我们欢迎开发者、设计师和社区成员加入，共同完善 AIREF 生态。

Fork 本仓库 到你的 GitHub 账户。

创建新分支：git checkout -b feature/your-feature。

提交修改：git commit -m 'Add new feature'。

推送分支：git push origin feature/your-feature。

在主仓库发起 Pull Request，描述修改内容和动机。

其他贡献方式包括：参与治理提案、撰写文档、组织社区活动、推广项目等。

🌍 社区链接

🌐 官方网站：airefugee.com

🐦 Twitter：https://x.com/AIRefugeeCoin

💬 Discord：https://discord.com/channels/1407176500964360343/

📢 Telegram：https://t.me/GoAIREF

📖 License

本项目使用 MIT 许可证开源，允许自由复制、修改和分发。详见仓库中的 LICENSE 文件。

✨ “AI displace us. Web3 found us.”
AIREF 因人工智能而生，为“AI 难民”创造新的数字归宿。
