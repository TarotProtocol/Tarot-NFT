import { utils } from "ethers";
import { Select } from "antd";
import React, { useState } from "react";
import { Address, AddressInput } from "../components";
import { useTokenList } from "eth-hooks/dapps/dex";

const { Option } = Select;

export default function Roadmap ({ yourLocalBalance, mainnetProvider, price, address }) {
  // Get a list of tokens from a tokenlist -> see tokenlists.org!
  const [selectedToken, setSelectedToken] = useState("Pick a token!");
  const listOfTokens = useTokenList(
    "https://raw.githubusercontent.com/SetProtocol/uniswap-tokenlist/main/set.tokenlist.json",
  );

  return (
    <div>
      <div style={{ height: 60 }}>
      </div>
      <div>
      </div>
    </div>
  );
}


//        <p style={{ marginLeft: "20%", marginRight: "20%", fontFamily: "Bonheur Royale", fontSize: 24 }}>Last but not least, in the centre of the
