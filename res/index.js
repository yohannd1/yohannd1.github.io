window.addEventListener("load", () => {
    const proj_list = document.getElementById("projects-list");
    const sb_div = proj_list.querySelector("#search-bar-div");

    const textbox = document.createElement("input");
    textbox.className = "search-bar";
    textbox.type = "text";
    textbox.placeholder = "Search...";
    sb_div.appendChild(textbox);

    const btn_search = document.createElement("button");
    btn_search.innerText = "Search";
    sb_div.appendChild(btn_search);

    const btn_clear = document.createElement("button");
    btn_clear.innerText = "Clear";
    sb_div.appendChild(btn_clear);

    const cards = proj_list.querySelectorAll(".project-row");
    const updateList = () => {
        const query = textbox.value;
        const words = query.split(/\s+/).map(x => x.toLowerCase());

        for (const card of cards) {
            let matched = true;
            const text = card.innerText.toLowerCase();

            for (let word of words) {
                if (text.indexOf(word) == -1) {
                    matched = false;
                    break;
                }
            }

            card.hidden = !matched;
        }
    };

    textbox.addEventListener("keypress", (ev) => {
        if (ev.key == "Enter") updateList();
    });
    btn_search.addEventListener("click", updateList);
    btn_clear.addEventListener("click", () => {
        textbox.value = "";
        textbox.focus();
        updateList();
    });

    for (const card of cards) {
        const tags = card.querySelector(".project-taglist");
        if (tags !== undefined) for (const tag of tags.querySelectorAll("div")) {
            tag.className += " project-tag-clickable";
            tag.addEventListener("click", () => {
                textbox.value = tag.innerText;
                textbox.focus();
                updateList();
            });
        }
    }
});
