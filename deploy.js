async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with account:", deployer.address);

  const NFTDrop = await ethers.getContractFactory("NFTDrop");
  const nft = await NFTDrop.deploy("MyCollection", "MYNFT", "ipfs://base-uri-here/");

  console.log("NFT Contract deployed to:", nft.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
