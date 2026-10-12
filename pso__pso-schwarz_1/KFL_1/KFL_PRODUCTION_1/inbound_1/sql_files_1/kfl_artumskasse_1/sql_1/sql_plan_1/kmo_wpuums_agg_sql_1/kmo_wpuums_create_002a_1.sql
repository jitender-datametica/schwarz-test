

CREATE  TABLE dbp_etl.kmo_wpuums_art_gp_wup_zu_1
(
  mandant_id         BYTEINT NOT NULL,
  art_id             INTEGER NOT NULL,
  wup_id             INTEGER NOT NULL,
  nb_id              SMALLINT NOT NULL,
  dat                DATE NOT NULL,
  bezugsweg_id       BYTEINT,
  anz_ek_infosatz    SMALLINT,   -- Anzahl Infosaetze (1 wenn nur ungueltige vorhanden sind)
  anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
  bq_gp_id           INTEGER,    -- GP_1 nach Bezugsquellenfindung
  bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
  bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
  regel_gp_id        INTEGER,    -- Regel GP_1 aus Einkaufsinfosatz
  regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
  ref_wup_id         INTEGER,    -- VZ aus Kreisprozess fuer Bezugsweg 4 oder wup_id fuer Bezugsweg 1 fuer Zugriff auf EINA_1 und EORD_1
  ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess fuer Bezugsweg 4 oder wup_id fuer Bezugsweg 1 fuer Zugriff auf EINA_1 und EORD_1
  kreistyp_gruppe_id CHAR(4) , -- Kreistyp_gruppe aus Marktstamm.
  wg_id              SMALLINT,   -- Warengruppe fuer Zugriff auf vz_wup_wg_zu_per
  umrechnungskurs    FLOAT       -- Kurs_1 fuer die Umrechnung von Landeswaehrung in Euro
)
;
