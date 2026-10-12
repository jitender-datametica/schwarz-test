CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_IMMO_OBJEKT_PER
AS
   -- STAMMDATEN Immobilie (immo_objekt)
   -- Akt. Datenstand : Gueltigkeitsdatum 31.12.9999
   -- 2012KW25 : Initial von IVS nach VIS übernommen, ohne Währungsumrechnung
   -- 2013KW02 : Transkription
   -- 2013KW10 Erweiterung Kurs/Waehrungsumrechnung

   SELECT
   io.mandant_id, io.immo_objekt_id, io.dat_von, io.dat_bis, io.objekt_groesse, io.konzessionaer_groesse, dbp_process.transcriptc(io.objekt_ort)     AS objekt_ort, 
   dbp_process.transcriptc(io.objekt_strasse) AS objekt_strasse, io.objekt_plz, dbp_process.transcriptc(io.objekt_name)    AS objekt_name, io.dat_1bereich_oeffnung, 
   io.dat_objekt_oeffnung, io.objektart_id, NULLIF(io.objektart_datum_von, '1900-01-01')        AS objektart_datum_von, 
   NULLIF(io.objektart_datum_bis, '9999-12-31')   AS objektart_datum_bis, io.eigenmiete_pro_qm    * kurs             AS eigenmiete_pro_qm, 
   io.eigenmiete_pro_monat * kurs             AS eigenmiete_pro_monat, 
   kurs.wrg_id, immo_objekt_obj_id, immo_objekt_bez, immo_objekt_nr, buchungskreis_id, dbp_process.transcriptc(
   CASE WHEN CHARINDEX( 'Partnerobjekt', objekt_name) > 0
   THEN TRIM(SUBSTRING(objekt_name, 1, CHARINDEX( 'Partnerobjekt', objekt_name) -1))
   ELSE objekt_name
   END
   ) AS objekt_name_grp
   FROM dbp_view.v_ivs_immo_objekt_per  io
   INNER JOIN dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per  kurs
   ON kurs.mandant_id = io.mandant_id

   WHERE io.dat_bis = '9999-12-31'

   -- Ermittlung der relevanten Objekt-Version bei Umgliederung
   -- Basis: Statusinformationen und Umgliederungsdatum
   AND (io.mandant_id, io.immo_objekt_id) NOT IN (
   SELECT mandant_id, immo_objekt_id
   FROM dbp_view.v_ivs_immo_objekt_per
   WHERE dat_bis = '9999-12-31'
   AND ( /*Daten der Umgliederung in der Zukunft*/
   dat_umgl > CURRENT_DATE
   OR
   ( /*mindestens ein Satz vorhanden mit Umgliederung in der Vergangenheit*/
   status_umgl = 'UMGL'
   AND dat_umgl IS NULL
   AND (mandant_id, ref_immo_objekt_id) IN (
   SELECT mandant_id, ref_immo_objekt_id
   FROM dbp_view.v_ivs_immo_objekt_per
   WHERE dat_umgl <= CURRENT_DATE AND dat_bis = '9999-12-31'
   )
   )
   )
   )

   UNION ALL  -- Dummy Objekt 0
   SELECT
   mandant_id,  'IW----------0', '1900-01-01', '9999-12-31', 0, 0, '', '', '', 'ohne Zuordnung', '1900-01-01', '1900-01-01', '3', '1900-01-01', '9999-12-31', 0.00, 0.00, wrg_id, 'IW----------0', 0, '', 0, 'ohne Zuordnung'
   FROM dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per  kurs
   ;