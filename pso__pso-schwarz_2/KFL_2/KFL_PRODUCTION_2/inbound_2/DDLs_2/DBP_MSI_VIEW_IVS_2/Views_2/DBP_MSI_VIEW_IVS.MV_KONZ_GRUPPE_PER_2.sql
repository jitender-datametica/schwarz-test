CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KONZ_GRUPPE_PER_2 as
                                                  -------------------------------------------------------------------
                                                  -- LOOKUP Stammdaten Konzessionaer Gruppe_2 (=Verbundkennzeichen1)
                                                  -- Neue Gruppierungsebene (entspricht Kova Konzessionaer)
                                                  -- 2011KW50 Initial Verbundkennz1 (konzessionaer_gruppe)
                                                  -- 2012KW07 Einschraenkung auf echte Holding + Dummy_2
                                                  -- 20120507 Review (Komplett umgebaut)
                                                  -- 2013KW02 Transkription ergaenzt
                                                  --------------------------------------------------------------------

                                                  SELECT
                                                  v01.mandant_id,
                                                  COALESCE(v01.konzessionaer_gruppe_id,'0') AS konz_gruppe_id,
                                                  dbp_process.transcriptc(COALESCE(v01.konzessionaer_name, v02.konz_gruppe_name,'')) AS konz_gruppe_name,
                                                  COALESCE(v02.holding_id, '0') AS holding_id,
                                                  COALESCE(v02.konz_gruppe_anz,0) AS konz_gruppe_anz,
                                                  v01.dat_von,
                                                  v01.dat_bis,
                                                  v01.land_id,
                                                  COALESCE(v02.konz_gruppe_plz,v01.konzessionaer_plz) AS konz_gruppe_plz,
                                                  dbp_process.transcriptc(COALESCE(v02.konz_gruppe_ort,v01.konzessionaer_ort)) AS konz_gruppe_ort,
                                                  dbp_process.transcriptc(COALESCE(v02.konz_gruppe_strasse,v01.konzessionaer_strasse)) AS konz_gruppe_strasse,
                                                  COALESCE(v02.konz_gruppe_rechtsform,v01.konzessionaer_rechtsform)   AS konz_gruppe_rechtsform,
                                                  COALESCE(v02.konz_gruppe_dat_insolvenz,v01.dat_insolvenz_eintritt)     AS konz_gruppe_dat_insolvenz,
                                                  COALESCE(v02.konz_gruppe_topmieter_fg,v01.konzessionaer_topmieter_fg) AS konz_gruppe_topmieter_fg,
                                                  COALESCE(v02.konz_gruppe_branche_id,v01.konzessionaer_branche_id, '000') AS konz_gruppe_branche_id
                                                  FROM dbp_view.v_ivs_konzessionaer_per_2 v01
                                                  LEFT OUTER JOIN
                                                  (
                                                  SELECT
                                                  mandant_id,
                                                  konzessionaer_gruppe_id  AS konz_gruppe_id,
                                                  CASE WHEN konzessionaer_holding_id <> konzessionaer_gruppe_id THEN konzessionaer_holding_id ELSE '0' END AS holding_id,
                                                  MAX(konzessionaer_name)         AS konz_gruppe_name,
                                                  COUNT(konzessionaer_id)         AS konz_gruppe_anz,
                                                  MAX(konzessionaer_plz)          AS konz_gruppe_plz,
                                                  MAX(konzessionaer_ort)          AS konz_gruppe_ort,
                                                  MAX(konzessionaer_strasse)      AS konz_gruppe_strasse,
                                                  MAX(konzessionaer_rechtsform)   AS konz_gruppe_rechtsform,
                                                  MAX(dat_insolvenz_eintritt)     AS konz_gruppe_dat_insolvenz,
                                                  MAX(konzessionaer_topmieter_fg) AS konz_gruppe_topmieter_fg,
                                                  MAX(konzessionaer_branche_id)   AS konz_gruppe_branche_id
                                                  FROM dbp_view.v_ivs_konzessionaer_per_2

                                                  WHERE dat_bis='9999-12-31'
                                                  AND konzessionaer_gruppe_id <> konzessionaer_id
                                                  AND konzessionaer_id <> '0'

                                                  GROUP BY
                                                  mandant_id
                                                  ,konz_gruppe_id
                                                  ,holding_id
                                                  ) v02
                                                  ON v01.mandant_id = v02.mandant_id
                                                  AND v01.konzessionaer_gruppe_id = v02.konz_gruppe_id

                                                  WHERE v01.dat_bis = '9999-12-31'
                                                  AND (v01.konzessionaer_gruppe_id = v01.konzessionaer_id OR v01.konzessionaer_id= '0')
;