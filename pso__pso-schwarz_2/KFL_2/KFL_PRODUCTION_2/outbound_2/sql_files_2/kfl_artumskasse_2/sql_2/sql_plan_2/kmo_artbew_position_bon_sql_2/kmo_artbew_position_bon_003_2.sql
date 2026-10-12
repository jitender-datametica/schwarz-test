--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- Regel GP_2 aus Einkaufsinfosatz
-- Ausstiegspunkt der Bezugsquellenfindung
-- Kreistyp_gruppe aus Marktstamm.

-- GP_2 nach Bezugsquellenfindung
-- Kurs_2 für die Umrechnung von Landeswährung in Euro

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- Ekorg nach Bezugsquellenfindung
-- Anzahl Orderbuch gepflegt
-- Warengruppe für Zugriff auf vz_wup_wg_zu_per

-- Regel Ekorg aus Einkaufsinfosatz
-- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
CREATE TABLE
IF NOT EXISTS dbp_etl.kmo_wpuums_art_gp_wup_zu_2 (
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
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);
