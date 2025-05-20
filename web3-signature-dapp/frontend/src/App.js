import React, { useState } from 'react';
import { ethers } from 'ethers';
import abi from '../../contracts/SignatureNFT.sol'; // adjust path as needed

const CONTRACT_ADDRESS = '<DEPLOYED_CONTRACT_ADDRESS>';

function App() {
  const [account, setAccount] = useState(null);
  const [athleteAddr, setAthleteAddr] = useState('');
  const [fanAddr, setFanAddr] = useState('');
  const [tokenURI, setTokenURI] = useState('');

  async function connectWallet() {
    if (window.ethereum) {
      const [addr] = await window.ethereum.request({ method: 'eth_requestAccounts' });
      setAccount(addr);
    }
  }

  async function mintNFT() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(CONTRACT_ADDRESS, abi.abi, signer);
    const tx = await contract.mint(athleteAddr, fanAddr, tokenURI);
    await tx.wait();
    alert('Minted!');
  }

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial' }}>
      <h1>Signature DApp</h1>
      {!account ? (
        <button onClick={connectWallet}>Connect Wallet</button>
      ) : (
        <p>Connected: {account}</p>
      )}
      <div style={{ marginTop: '1rem' }}>
        <input
          placeholder="Athlete Address"
          value={athleteAddr}
          onChange={e => setAthleteAddr(e.target.value)}
        />
        <input
          placeholder="Fan Address"
          value={fanAddr}
          onChange={e => setFanAddr(e.target.value)}
        />
        <input
          placeholder="Token URI"
          value={tokenURI}
          onChange={e => setTokenURI(e.target.value)}
        />
        <button onClick={mintNFT}>Mint NFT</button>
      </div>
    </div>
  );
}

export default App;
