import { SyncOutlined } from "@ant-design/icons";
import { utils } from "ethers";
import { Button, Card, DatePicker, Divider, Input, List, Progress, Slider, Spin, Switch } from "antd";
import React, { useState } from "react";
import { Address, Balance } from "../components";

export default function MintTarotUI({
  address,
  mainnetProvider,
  localProvider,
  yourLocalBalance,
  price,
  tx,
  readContracts,
  writeContracts,
}) {

  return (
    <div>
      <div style={{ height: 60 }}>
      </div>
      <div style={{ height: 200 }}>
        <img src="banner.png" width="300"/>
      </div>
      <div>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>Tarot Protocol is the first pathway
        into the Collective Unconscious through blockchain, bridging the digital world with the spiritual world.</p>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>When you hit the "mint" button below,
        synchronicity happens, materializing in a Tarot spread uniquely linked to you. Through the spread,
        the truth previously unbeknownst to you reveals itself.</p>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>The Tarot Protocol is a collection of
        7,777 unique 7-Tarot-card spreads, each card drawn and minted on the Ethereum blockchain.
        Spread #1 to #7000 are available for minting by anyone at a cost of Ξ0.02 each; whereas spread
        #7001 to #7777 are currently reserved for the hardworking souls behind this project, as well as
        for future community events.</p>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>We humble digital diviners merely provide the tools.
        YOU are the one to delve deep into your own psyche and receive the message.
        As a free soul, you are free to interpret and use the spread you mint however you desire.
        Remember this: if there is such thing as destiny, one is destined to make one's own destiny.</p>
      </div>
      <div style={{ border: "1px solid #cccccc", padding: 16, width: 700, margin: "auto", marginTop: 64 }}>
        <div style={{ margin: 8 }}>
          <img src="pickcard.jpg" z-order="-1"/>
          <Button style={{ marginTop: 16 }}
            onClick={() => {
              tx(
                writeContracts.Tarot.claimNext({
                  value: utils.parseEther("0.02"),
                }),
              );
            }}
          >
            Mint Tarot Spread for Ξ0.02
          </Button>
        </div>
      </div>
    </div>
  );
}
