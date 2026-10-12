CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_LIEF_EINTEILUNG_2
   -- 22.09.2015 twie: initial; Ermittlung statistisches Lieferdatum

   (
   mandant_id
   ,best_beleg_id
   ,best_beleg_pos_id
   ,dat_lief_statistisch
   )
   AS
      SELECT

      v01.mandant_id,
      v01.best_beleg_id,
      v01.best_beleg_pos_id,
      v01.dat_lief_statistisch

      FROM dbp_view.v_in_lief_einteilung_2 v01

      -- gibt für jede Belegposition nur einen Datensatz aus, den mit der niedrigsten einteil_id
      -- damit wird immer ein eindeutiges dat pro Position ausgegeben
      QUALIFY ROW_NUMBER() OVER (PARTITION BY
      v01.mandant_id
      ,v01.best_beleg_id
      ,v01.best_beleg_pos_id
      ORDER BY v01.einteil_id ASC) = 1
;