CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_MIETVERTRAG_HIST_2


(
mietvertrag_id
,mandant_id
,dat_bis
,dat_von
,debitor_werbung_id
,debitor_miete_id
,vertragart_id
,konzessionaer_id
,vermieter_id
,vertrag_status_fg
,dat_vertrag_beginn
,dat_vertrag_ende
,dat_kuendbar_zum
,dat_kuendigung
,kuendigung_frist
,kuend_frist_bez
,betrag_kaution
,nebenkosten_betrag
,nebenkosten_abschlag
,sonderregelung_fg
,wrg_id
,mietindex_prozent
,dat_mietindex
,mietauftrag_id
,mietvertrag_option
--,mietvertrag_option2
--,mietvertrag_option3
,mietvertrag_nr
)
AS

   SELECT
   mietvertrag_id,
   mandant_id,
   dat_bis,
   dat_von,
   debitor_werbung_id,
   debitor_miete_id,
   vertragart_id,
   konzessionaer_id,
   vermieter_id,
   vertrag_status_fg,
   dat_vertrag_beginn,
   dat_vertrag_ende,
   dat_kuendbar_zum,
   dat_kuendigung,
   kuendigung_frist,
   kuend_frist_bez,
   betrag_kaution,
   nebenkosten_betrag,
   nebenkosten_abschlag,
   sonderregelung_fg,
   wrg_id,
   mietindex_prozent,
   dat_mietindex,
   mietauftrag_id,
   mietvertrag_option,
   mietvertrag_nr

   FROM dbp_view.v_ivs_mietvertrag_per_2
   WHERE  (mandant_id, mietvertrag_id, dat_von) IN
   (SELECT mandant_id,
   mietvertrag_id,
   MAX(dat_von) FROM dbp_view.v_ivs_mietvertrag_per_2 GROUP BY mandant_id, mietvertrag_id)

  UNION ALL  -- Dummy_2-Mietvertrag (pro Mandant_2/Waehrung)
  SELECT
  '0'  AS mietvertrag_id,
   mwt.mandant_id,
   '1900-01-01' AS dat_von,
  '9999-12-31' AS dat_bis,
   0::DECIMAL(18,0) AS debitor_werbung_id,
   0::DECIMAL(18,0) AS debitor_miete_id,
   '000'::CHAR(3) AS vertragart_id,
   '0'  AS konzessionaer_id,
   mwt.mandant_id * -1::INTEGER AS vermieter_id,
   '0'::CHAR(1) AS vertrag_status_fg,
'1900-01-01' AS dat_vertrag_beginn,
'9999-12-31' AS dat_vertrag_ende,
'9999-12-31' AS dat_kuendbar_zum,
'9999-12-31' AS dat_kuendigung,
   0::INTEGER AS kuendigung_frist,
   ''::VARCHAR(20) AS kuend_frist_bez,
   0::DECIMAL(18,4) AS betrag_kaution,
   0::DECIMAL(18,4) AS nebenkosten_betrag,
   0::DECIMAL(18,4) AS nebenkosten_abschlag,
   0::BYTEINT AS sonderregelung_fg,
   mwt.wrg_id,
   0::DECIMAL(9,4) AS mietindex_prozent,
'1900-01-01'  AS dat_mietindex,
   0::BYTEINT mietauftrag_id,
   ''::VARCHAR(10) mietvertrag_option,
   '0' AS mietauftrag_nr

   FROM dbp_view.v_mandant_wrg_typ_zu_2 mwt
   WHERE wrg_id='EUR';