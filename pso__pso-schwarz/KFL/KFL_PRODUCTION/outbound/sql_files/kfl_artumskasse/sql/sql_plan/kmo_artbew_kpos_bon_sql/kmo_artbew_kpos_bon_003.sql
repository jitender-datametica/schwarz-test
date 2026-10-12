--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


-- GP nach Bezugsquellenfindung
-- Regel GP aus Einkaufsinfosatz
-- Anzahl Orderbuch gepflegt

-- Ausstiegspunkt der Bezugsquellenfindung

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD

-- Kreistyp_gruppe aus Marktstamm.
-- Regel Ekorg aus Einkaufsinfosatz

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD

-- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
-- Ekorg nach Bezugsquellenfindung

-- Warengruppe für Zugriff auf vz_wup_wg_zu_per
-- Kurs für die Umrechnung von Landeswährung in Euro
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
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);
