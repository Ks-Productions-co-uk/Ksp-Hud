// Cache DOM elements
const hudElements = {
    main: document.getElementById('hud'),
    extraHud: document.getElementById('extraHud'),
    infobar: document.querySelector('.infobar-container'),
    settings: document.getElementById('settings-panel'),
    singleLineText: document.getElementById('singleLineText'),
    colorOptions: document.querySelector('.color-options')
};

let currentColors = {
    background: "rgba(0, 200, 255, 0.377)",
    border: "#00c8ff80",
    shadow: "rgba(0, 200, 255, 0.3)"
};

document.addEventListener('DOMContentLoaded', function() {
    const savedColors = localStorage.getItem('hudColors');
    if (savedColors) {
        applyColors(JSON.parse(savedColors));
    }
});

window.addEventListener('message', function(event) {
    const { type } = event.data;
    
    switch(type) {
        case "updateHUD":
            hudElements.main.style.display = 'block';
            hudElements.infobar.style.display = 'flex';
            hudElements.extraHud.style.display = 'block';
            updateHUDValues(event.data);
            break;
            
        case "toggleHUD":
            const display = event.data.show;
            hudElements.main.style.display = display ? 'block' : 'none';
            hudElements.infobar.style.display = display ? 'flex' : 'none';
            hudElements.extraHud.style.display = display ? 'block' : 'none';
            break;
            
        case "openConfigMenu":
            if (event.data.colorPresets) {
                setupColorSettings(event.data.colorPresets);
            }
            hudElements.settings.style.display = 'block';
            break;
            
        case "updateInfobar":
            updateInfobar(event.data);
            break;
            
        case "updateSingleLineText":
            updateSingleLineText(event.data.text);
            break;
    }
});

function updateHUDValues(data) {
    const updates = {
        'playerId': data.playerId,
        'cash': data.cash.toLocaleString(),
        'bank': data.bank.toLocaleString(),
        'job': data.job,
        'grade': data.grade,
        'gang': data.gang,
        'ganggrade': data.ganggrade
    };

    Object.entries(updates).forEach(([id, value]) => {
        updateHUDValue(id, value);
    });
}

function setupColorSettings(presets) {
    const fragment = document.createDocumentFragment();
    
    presets.forEach(preset => {
        const option = document.createElement('div');
        option.className = 'color-option';
        option.innerHTML = `
            <i class="fa-solid fa-palette" style="color: ${preset.border}; margin-right: 15px;"></i>
            <span>${preset.name}</span>
        `;
        option.onclick = () => applyColors(preset);
        fragment.appendChild(option);
    });
    
    hudElements.colorOptions.innerHTML = '';
    hudElements.colorOptions.appendChild(fragment);
}

function applyColors(colors) {
    currentColors = colors;
    localStorage.setItem('hudColors', JSON.stringify(colors));
    
    const elements = [
        document.querySelector('.hud-container'),
        hudElements.extraHud,
        hudElements.infobar,
        hudElements.settings,
        document.documentElement.style.setProperty('--border-color', colors.border)
    ];

    elements.forEach(element => {
        if (element) {
            element.style.background = colors.background;
            element.style.borderColor = colors.border;
            element.style.boxShadow = `0 0 5px #fff, 0 0 10px #fff, 0 0 15px ${colors.shadow}, 0 0 20px ${colors.shadow}`;
        }
    });

    document.querySelectorAll('.fa, .fas, .far, .fab').forEach(icon => {
        if (!icon.classList.contains('fa-palette')) {
            icon.style.color = colors.border;
        }
    });
}

function updateSingleLineText(text) {
    if (hudElements.singleLineText) {
        hudElements.singleLineText.innerHTML = `<i class="fa-regular fa-circle-left"></i> ${text} <i class="fa-regular fa-circle-right"></i>`;
    }
}

function updateHUDValue(id, value) {
    const element = document.getElementById(id);
    if (element && element.textContent !== value) {
        element.textContent = value;
    }
}

function updateInfobar(data) {
    const updates = {
        'fps-value': data.fps,
        'time-value': data.time,
        'players-value': data.players
    };

    Object.entries(updates).forEach(([id, value]) => {
        const element = document.getElementById(id);
        if (element) element.textContent = value;
    });
}

document.querySelector('.close-settings').addEventListener('click', function() {
    hudElements.settings.style.display = 'none';
    fetch(`https://${GetParentResourceName()}/closeConfigMenu`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    });
});
