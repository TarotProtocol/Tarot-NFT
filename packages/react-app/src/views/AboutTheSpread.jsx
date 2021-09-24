import { utils } from "ethers";
import { Select } from "antd";
import React, { useState } from "react";
import { Address, AddressInput } from "../components";
import { useTokenList } from "eth-hooks/dapps/dex";

const { Option } = Select;

export default function AboutTheSpread ({ yourLocalBalance, mainnetProvider, price, address }) {
  // Get a list of tokens from a tokenlist -> see tokenlists.org!
  const [selectedToken, setSelectedToken] = useState("Pick a token!");
  const listOfTokens = useTokenList(
    "https://raw.githubusercontent.com/SetProtocol/uniswap-tokenlist/main/set.tokenlist.json",
  );

  return (
    <div>
      <div style={{ height: 60 }}>
      </div>
        <p style={{ marginLeft: "20%", marginRight: "20%", fontFamily: "Bonheur Royale", fontSize: 60 }}>Seal of Solomon Spread</p>
      <div style={{ height: 350 }}>
        <img src="spread_interpretation.png" width="300"/>
      </div>
      <div>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>The 7-card spread Tarot Protocol
        draws is known by many different names throughout history. To many practitioners of the Art,
        however, it is none other than the Seal of Solomon Spread, in recognition of the magical potencies
        locked behind the ultra symmetric formation.</p>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>The Seal of Solomon Spread starts with
        three cards forming an upright triangle, representing the past, the present, and the future.
        It concerns things and matters as they appear in the physical reality.</p>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>The next three cards forming a downward
        triangle deal with the current situation, and those obstacles and opportunities lying ahead,
        those mental and karmic forces behind all the twists and turns of how things unfold.</p>
        <p style={{ marginLeft: "20%", marginRight: "20%" }}>Last but not least, in the centre of the
        spread sits an advice card that suggests, all things considered, a viable approach for you
        to overcome the challenges in stock for you.</p>
      </div>
    </div>
  );
}


//        <p style={{ marginLeft: "20%", marginRight: "20%", fontFamily: "Bonheur Royale", fontSize: 24 }}>Last but not least, in the centre of the
