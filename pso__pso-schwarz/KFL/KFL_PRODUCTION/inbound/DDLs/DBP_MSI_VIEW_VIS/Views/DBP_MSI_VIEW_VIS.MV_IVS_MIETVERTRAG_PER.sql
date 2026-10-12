CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_MIETVERTRAG_PER
AS
   -- 2009-06-18
   -- FAKTVIEW mietvertrag_per (aktueller Datenstand)
   -- 2012KW25 Initial von IVS nach VIS, ohne Währungsumrechnung
   -- 2013KW10 Erweiterung Kurs/Waehrungsumrechnung

   SELECT
   mv.mandant_id, mv.mietvertrag_id, mv.mietvertrag_nr, mv.dat_von, mv.dat_bis, mv.dat_vertrag_beginn, COALESCE(mv.dat_vertrag_ende, CAST('9999-12-31' AS VARCHAR)) dat_vertrag_ende, mv.vertragart_id, mv.vertrag_status_fg, mv.konzessionaer_id, mv.vermieter_id, CASE WHEN mv.dat_vertrag_ende BETWEEN CURRENT_DATE AND '9999-12-01'
   THEN (dat_vertrag_ende - CURRENT_DATE) / 30
   ELSE 0
   END::INTEGER laufzeit_ende, CASE WHEN mv.dat_vertrag_beginn BETWEEN '2031-01-01' AND CURRENT_DATE
   THEN (CURRENT_DATE - dat_vertrag_beginn) / 30
   ELSE 0
   END::INTEGER laufzeit_beginn, COALESCE(mv.dat_kuendbar_zum, CAST('9999-12-31' AS VARCHAR)) dat_kuendbar_zum, dat_kuendigung, COALESCE(mv.kuendigung_frist, CAST(0 AS INTEGER)) AS kuendigung_frist, COALESCE(mv.kuend_frist_bez, CAST('' AS VARCHAR(20))) AS kuend_frist_bez, mv.betrag_kaution * kurs       AS kaution, mv.nebenkosten_betrag * kurs   AS nebenkosten_betrag, mv.nebenkosten_abschlag * kurs AS nebenkosten_abschlag, mv.sonderregelung_fg, mv.mietindex_prozent, mv.dat_mietindex, mv.mietauftrag_id, mv.mietvertrag_option, mv.mietvertrag_option          AS option_bez, mv.debitor_miete_id    -- not used anymore
   , mv.debitor_werbung_id  -- not used anymore
   , kurs.wrg_id
   FROM dbp_view.v_ivs_mietvertrag_per  mv
   INNER JOIN dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per  kurs
   ON kurs.mandant_id = mv.mandant_id

   WHERE mv.dat_bis = '9999-12-31'

   UNION ALL  -- Dummy-Mietvertrag (pro Mandant/Waehrung)
   SELECT
   mwt.mandant_id, '0' AS mietvertrag_id, '0' AS mietvertrag_nr, CAST(101 AS VARCHAR) AS dat_von, CAST('9999-12-31' AS VARCHAR) AS dat_bis, CAST(101 AS VARCHAR) AS dat_vertrag_beginn, CAST('9999-12-31' AS VARCHAR) AS dat_vertrag_ende, '000'::CHAR(3) AS vertragart_id, '0'::CHAR(1) AS vertrag_status_fg, '0'::VARCHAR(20) AS konzessionaer_id, mwt.mandant_id * -1::INTEGER AS vermieter_id, CAST (0 AS INTEGER) AS laufzeit_ende, CAST (0 AS INTEGER) AS laufzeit_beginn, CAST(80991231 AS VARCHAR) AS dat_kuendbar_zum, CAST(80991231 AS VARCHAR) AS dat_kuendigung, 0::INTEGER AS kuendigung_frist, ''::VARCHAR(20) AS kuend_frist_bez, 0::DECIMAL(18,4) AS betrag_kaution, 0::DECIMAL(18,4) AS nebenkosten_betrag, 0::DECIMAL(18,4) AS nebenkosten_abschlag, 0::BYTEINT AS sonderregelung_fg, 0::DECIMAL(9,4) AS mietindex_prozent, CAST(101 AS VARCHAR)  AS dat_mietindex, 0::BYTEINT mietauftrag_id, ''::VARCHAR(10) mietvertrag_option, ''::VARCHAR(40) AS option_bez, 0::DECIMAL(18,0) AS debitor_miete_id, 0::DECIMAL(18,0) AS debitor_werbung_id, mwt.wrg_id
   FROM dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per   mwt
   ;