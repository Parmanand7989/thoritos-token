require('@nomiclabs/hardhat-ethers');

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/38420b893061455e9aed55cd19f073ef",
      accounts: [`b048bc5f9189810403319908a17be5db7d57e20e662c4c0d2731287d626ce1c7`]
    },

    bscTestnet: {
      url: "https://go.getblock.io/c4feb2e91e544d918c4379b14ebbcef8",
      accounts: [`b048bc5f9189810403319908a17be5db7d57e20e662c4c0d2731287d626ce1c7`]
    }
  }
};
