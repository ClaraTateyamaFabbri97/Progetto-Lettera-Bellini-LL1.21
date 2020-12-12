var pag1;
var pag2;
var pag3;
var pag4;
var pagine;
var visibile;
var bottonePrem;
var fraseEvid;

//La funzione nasconde la scansione e la trascrizione della pagina.
function nascondiPag (pag) {
    pag[0].style.display = "none";
    pag[1].style.display = "none";
    if (pag[2])
        pag[2].style.display = "none";
};

//La funzione mostra la scansione e la trascrizione della pagina.
function mostraPag (pag) {
    pag[0].style.display = "block";
    pag[1].style.display = "block";
    if (pag[2])
        pag[2].style.display = "flex";
    visibile = pag;
};

//Allo scorrere della galleria, la funzione, richiamando le rispettive funzioni, nasconde la pagina corrente e mostra la successiva.
function scorri (freccia) {
    nascondiPag(visibile);
    var i = pagine.indexOf(visibile);
    if (freccia == document.getElementById("arrowb")) {
        if (i == 0)
            mostraPag(pag4);
        else
            mostraPag(pagine[i-1]);
    } else {
        if (i == 3)
            mostraPag(pag1);
        else
            mostraPag(pagine[i+1]);
    };
};

//Al click sul titolo della nota visibile, la funzione nasconde il suo contenuto.
function nascondiNota (nota) {
    nota.nextSibling.style.display = "none";
    nota.innerHTML = nota.innerHTML.replace("\u25B4", "\u25BE");
    nota.setAttribute("onclick", "mostraNota(this)");
};

//Al click sul titolo della nota non visibile, la funzione mostra il suo contenuto.
function mostraNota (nota) {
    nota.nextSibling.style.display = "block";
    nota.innerHTML = nota.innerHTML.replace("\u25BE", "\u25B4");
    nota.setAttribute("onclick", "nascondiNota(this)");
};

//Al click sul link che rimanda a una nota, la funzione controlla se la nota è già visibile, altrimenti richiama la funzione per farla apparire.
function linkaNota (nodoLink) {
    var nota = document.getElementById(nodoLink.getAttribute("href").replace("#", "")).firstChild;
    if (nota.innerHTML) {
        if (nota.innerHTML.indexOf("\u25BE") != -1)
            mostraNota(nota);
    };
};

//All'uscita del mouse dall'area delle righe della lettera nella scansione o dei numeri di riga nella trascrizione, la funzione rimuove l'alone.
function disevidenzia (nodo) {
    var nodi = document.getElementsByClassName(nodo.getAttribute("class").replace("line ", ""));
    for (var n of nodi)
        n.style.removeProperty("background-color");
};

//Al passaggio del mouse sulle righe della lettera nella scansione o sui numeri di riga nella trascrizione, la funzione genera un alone.
function evidenzia (nodo) {
    var nodi = document.getElementsByClassName(nodo.getAttribute("class").replace("line ", ""));
    for (var n of nodi)
        n.style.backgroundColor = "rgba(255,127,0,0.5)";
};


//Al caricamento della pagina html, vengono nascoste le scansioni e le trascrizioni delle pagine successive alla prima.
window.onload = function () {
    pag1 = [document.getElementById("LL1.21_folio_1fr"), document.getElementById("fronte-recto")];
    pag2 = [document.getElementById("LL1.21_folio_1rr"), document.getElementById("retro-recto")];
    pag3 = [document.getElementById("LL1.21_folio_1rv"), document.getElementById("retro-verso")];
    pag4 = [document.getElementById("LL1.21_folio_1fv"), document.getElementById("fronte-verso")];
    pagine = [pag1, pag2, pag3, pag4];
    nascondiPag(pag2);
    nascondiPag(pag3);
    nascondiPag(pag4);
    visibile = pag1;
    bottonePrem = false;
    fraseEvid = false;
};