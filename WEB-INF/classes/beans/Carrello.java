package beans;

import java.util.HashMap;
import java.util.Iterator;

public class Carrello {
    private HashMap<String, Integer> carrello = new HashMap<String, Integer>();

    public Carrello() {
    }

    public void addItem(String item) {
        if (carrello.containsKey(item)) {
            // aggiorno la quantità del prodotto
            Integer numero = carrello.get(item) + 1;
            carrello.replace(item, numero);
        } else {
            carrello.put(item, 1);
        }
    }

    public Iterator<String> getIDArray() {
        if (!carrello.isEmpty()) {
            Iterator<String> iteratore = carrello.keySet().iterator();
            return iteratore;
        } else {
            return null;
        }
    }

    public Boolean isEmpty() {
        return carrello.isEmpty();
    }

    public String getQuantita() {
        Iterator<Integer> pezzi = (Iterator<Integer>) carrello.values().iterator();
        Integer totpezzi = 0;
        while (pezzi.hasNext()) {
            totpezzi = totpezzi + pezzi.next();
        }
        return String.valueOf(totpezzi);
    }

    public Integer getQuantitaItem(String item) {
        return carrello.get(item);
    }

    public void eliminaItem(String item) {
        carrello.remove(item);
    }

}
