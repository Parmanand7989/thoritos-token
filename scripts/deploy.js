async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const ThoritosToken = await ethers.getContractFactory("ThoritosToken");
    const thoritos = await ThoritosToken.deploy();

    console.log("Thoritos Token deployed to:", thoritos.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
