import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <div style={{ position: "fixed", textAlign: "left", left: 0, top: 0, padding: 0, width: "100%", zIndex: 100, background: "#000000" }}>
      <img src="logo.png" height="100" style={{marginLeft: "20px"}} />
      <a href="https://opensea.io/collection/tarot-protocol">
        <img src="opensea.png" height="16" style={{marginLeft: "20px", marginBottom: "20px", verticalAlign: "bottom"}} />
      </a>
      <a href="https://twitter.com/TarotProtocol">
        <img src="twitter.png" height="16" style={{marginLeft: "10px", marginBottom: "20px", verticalAlign: "bottom"}} />
      </a>
      <a href="https://discord.gg/SrQG4Xprza">
        <img src="discord.png" height="16" style={{marginLeft: "10px", marginBottom: "20px", verticalAlign: "bottom"}} />
      </a>
    </div>
  );
}

/*
      <a href="https://tarot-nft.io" target="_blank" rel="noopener noreferrer">
        <PageHeader
          title="🔮 Tarot Protocol"
          subTitle="The Blockchain Pathway to the Collective Unconscious"
          style={{ cursor: "pointer" }}
        />
      </a>
 */
