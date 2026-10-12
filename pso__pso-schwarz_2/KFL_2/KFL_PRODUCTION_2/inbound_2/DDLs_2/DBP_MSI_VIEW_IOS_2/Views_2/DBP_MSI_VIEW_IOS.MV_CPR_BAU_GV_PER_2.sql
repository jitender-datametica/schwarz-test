CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_BAU_GV_PER_2

-- 20140711 (K.Kaiser) Proj. 577 neue VIEW
-- 20140821 (K.Kaiser) Proj. 577 cpr_systemstatus1_id mit aufgenommen
-- 20140822 (K.Kaiser) Proj. 577 Kennzeichen bau_gv_abgebrochen: Ablauf Baugenehmigung > DATE UND cpr_systemstatus1_id = 4
-- 20141118 (K.Kaiser) Proj. 577 Einschränkung auf v01.dat_bis = 80991231
(
projekt_id
,projekt_nr
,dat_von
,bau_gv_dok_id
,dat_bis
,dok_ersteller_name
,datzeit_erstellung
,dok_aenderer_name
,datzeit_aenderung
,dok_gueltig_bis
,dok_aktenzeichen
,dok_dat_eingang
,dokumentart_bez
,dokument_unterart_bez
,dok_relevanz_kz
,cpr_systemstatus1_id
,bau_gv_abgebrochen
,aktuelles_datum
,mandant_id
)
AS
   SELECT
   v01.projekt_id, v02.cpr_ext_id, v01.dat_von, v01.bau_gv_dok_id, v01.dat_bis, v01.dok_ersteller_name, v01.datzeit_erstellung, v01.dok_aenderer_name, v01.datzeit_aenderung, v01.dok_gueltig_bis, v01.dok_aktenzeichen, v01.dok_dat_eingang, v01.dokumentart_bez, v01.dokument_unterart_bez, v01.dok_relevanz_kz, COALESCE(v02.cpr_systemstatus1_id,4) AS cpr_systemstatus1_id, CASE
   WHEN (v02.cpr_systemstatus1_id = 4 OR v02.cpr_systemstatus1_id IS NULL) AND v01.dok_gueltig_bis > CURRENT_DATE
   THEN 1 ELSE 0 END  AS bau_gv_abgebrochen, CURRENT_DATE AS aktuelles_datum, v02.mandant_id

   FROM dbp_view.v_cpr_bau_gv_per_2 v01
   LEFT JOIN dbp_view.v_cpr_projekt_per_2  v02
   ON  v01.projekt_id = v02.projekt_id
   AND v02.dat_bis = '9999-12-31'

   WHERE
   v01.dok_ordner_id <> 'X'
   AND v01.dat_bis = '9999-12-31'
   AND dok_status_id = 'E0001';