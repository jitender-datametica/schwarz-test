-- Regel GP aus Einkaufsinfosatz

-- VZ aus Kreisprozess fuer Bezugsweg 4 oder wup_id fuer Bezugsweg 1 fuer Zugriff auf EINA und EORD

-- Warengruppe fuer Zugriff auf vz_wup_wg_zu_per
-- Anzahl Infosaetze (1 wenn nur ungueltige vorhanden sind)

-- Regel Ekorg aus Einkaufsinfosatz
-- Kreistyp_gruppe aus Marktstamm.

-- Kurs fuer die Umrechnung von Landeswaehrung in Euro
-- Ekorg nach Bezugsquellenfindung

-- VZ aus Kreisprozess fuer Bezugsweg 4 oder wup_id fuer Bezugsweg 1 fuer Zugriff auf EINA und EORD

-- Ausstiegspunkt der Bezugsquellenfindung
-- Anzahl Orderbuch gepflegt
-- GP nach Bezugsquellenfindung
CREATE TABLE
IF NOT EXISTS dbp_etl.kmo_wpuums_art_gp_wup_zu (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4),
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);
