import ds from 'downstream';

const images = [
'https://branding.polysensus.io/assets/images/favicon1/apple-icon-120x120-white.png',
'https://branding.polysensus.io/assets/images/splash/polysensus-white-on-black-square.jpg',
'https://branding.polysensus.io/assets/images/splash/polysensus-black-on-white-square.jpg',
'https://branding.polysensus.io/assets/images/favicon1/apple-icon-120x120.png',
// 'https://assets.downstream.game/examples/disco-beaver-0.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-1.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-2.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-3.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-4.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-5.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-6.jpeg',
// 'https://assets.downstream.game/examples/disco-beaver-7.jpeg',
];

// let selectedImg = Math.floor(Math.random() * images.length) + 1;
let selectedImg = 0;

const changeImg = () => {
    selectedImg = (selectedImg + 1) % images.length;
};

export default async function update(state) {
    const discoBillboard = state.world?.buildings.find(
        (b) => b.kind?.name?.value == "Disco Billboard",
    );

    if (!discoBillboard){
        return;
    }

    const map = [
        {
        type: "building",
        key: "image",
        id: `${discoBillboard.id}`,
        value: images[selectedImg],
        },
    ];

    const buttons = [
        {
            text: `Change Billboard Image 🔄`,
            type: 'action',
            action: changeImg,
            disabled: false,
        },
    ];

    return {
        version: 1,
        map: map,
        components: [
            {
                id: 'disco-billboard',
                type: 'building',
                content: [
                    {
                        id: 'default',
                        type: 'inline',
                        html: `
                            <h3>Now Showing:</h3>
                            <img src="${images[selectedImg]}" alt="Current Billboard Image">
                            [${selectedImg + 1}/${images.length}]
                        `,
                        buttons: buttons,
                    },
                ],
            },
        ],
    };
}

// the source for this code is on github where you can find other example buildings:
// https://github.com/playmint/ds/tree/main/contracts/src/example-plugins
