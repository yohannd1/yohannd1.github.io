window.addEventListener("load", () => {
    const newKeyIndicator = function (name) {
        const el = document.createElement("p");
        el.className = "subnode";
        el.innerText = name;
        return el;
    };

    const pressed_keys = {};
    const list = document.getElementById("pressed-keys-list");

    window.addEventListener("keydown", (ev) => {
        let p = pressed_keys[ev.code];
        if (p === undefined) {
            p = newKeyIndicator(ev.code);
            pressed_keys[ev.code] = p;
            list.append(p);
        }
        p.hidden = false;
    });
    window.addEventListener("keyup", (ev) => {
        const p = pressed_keys[ev.code];
        if (p === undefined) return;
        p.hidden = true;
    });
});
