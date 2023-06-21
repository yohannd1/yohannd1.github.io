window.addEventListener("load", () => {
    const proj_list = document.getElementById("projects-list");

    const textbox = document.createElement("input");
    textbox.className = "search-bar";
    textbox.type = "text";
    textbox.placeholder = "Search...";
    proj_list.prepend(textbox);

    const btn_search = document.createElement("button");
    btn_search.innerText = "Search";
    proj_list.insertBefore(btn_search, textbox.nextSibling);

    const btn_clear = document.createElement("button");
    btn_clear.innerText = "Clear";
    proj_list.insertBefore(btn_clear, btn_search.nextSibling);

    const cards = proj_list.querySelectorAll(".project-card");
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
