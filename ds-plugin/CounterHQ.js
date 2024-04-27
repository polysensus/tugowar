import ds from "downstream";

const counterHQName = "Tug Of War"

export default async function update(state) {
    const mobileUnit = getMobileUnit(state);
    const buildings = state.world?.buildings || [];
    const counterHQ = getBuildingsByType(buildings, counterHQName)[0];
    if (!counterHQ)
      console.error(`building ${counterHQName} not found`)
    const score = getDataInt(counterHQ, "score");

    const counterBuildings = getBuildingsByType(buildings, "counter");

    const readScore = () => {
        const payload = ds.encodeCall("function readScore()", []);
        ds.dispatch({
            name: "BUILDING_USE",
            args: [counterHQ.id, mobileUnit.id, payload],
        });
    };

    const joinTheLight = () => {
        const payload = ds.encodeCall("function joinTheLight()", []);
        ds.dispatch({
            name: "BUILDING_USE",
            args: [counterHQ.id, mobileUnit.id, payload],
        });
    };

    return {
        version: 1,
        map: counterBuildings.map((b) => ({
            type: "building",
            id: `${b.id}`,
            key: "labelText",
            value: `${score}`,
        })),
        components: [
            {
                id: "counter-hq",
                type: "building",
                content: [
                    {
                        id: "default",
                        type: "inline",
                        html: ``,

                        buttons: [
                            {
                                text: "What's the Score?!",
                                type: "action",
                                action: readScore,
                            },
                            {
                              /*  todo: disable this once joined and while games
                               *  in progress */
                                text: "Join the Light!",
                                type: "action",
                                action: joinTheLight,
                            },
                        ],
                    },
                ],
            },
        ],
    };
}

function getMobileUnit(state) {
    return state?.selected?.mobileUnit;
}

const getBuildingsByType = (buildingsArray, type) => {
    return buildingsArray.filter(
        (building) =>
            building.kind?.name?.value.toLowerCase().trim() ==
            type.toLowerCase().trim(),
    );
};

// -- Onchain data helpers --

function getDataInt(buildingInstance, key) {
    var hexVal = getData(buildingInstance, key);
    return typeof hexVal === "string" ? parseInt(hexVal, 16) : 0;
}

function getData(buildingInstance, key) {
    return getKVPs(buildingInstance)[key];
}

function getKVPs(buildingInstance) {
    return (buildingInstance.allData || []).reduce((kvps, data) => {
        kvps[data.name] = data.value;
        return kvps;
    }, {});
}
