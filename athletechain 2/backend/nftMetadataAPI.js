
// Example Node.js (Express-style) metadata server
const express = require('express');
const app = express();
const PORT = 3001;

const sampleMetadata = {
  "name": "Signed Basketball by Athlete X",
  "description": "This NFT certifies that the holder owns a basketball signed by Athlete X. Redeemable for a meet & greet at AthleteCon 2025.",
  "image": "https://example.com/images/signed-ball.png",
  "attributes": [
    {
      "trait_type": "Utility",
      "value": "Redeemable Meet & Greet"
    },
    {
      "trait_type": "Athlete",
      "value": "Athlete X"
    }
  ]
};

app.get('/nft/:tokenId', (req, res) => {
    res.json(sampleMetadata);
});

app.listen(PORT, () => {
    console.log(`NFT Metadata server running on http://localhost:${PORT}`);
});
