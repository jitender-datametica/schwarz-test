CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_BELOS_VORGANG_1
--26.10.2018 SNIK1809: SPEC0041902
--10.12.2018: Naku2305:   View angepasst- aufmahme alle Felder aus der belos_vorgang_1 Tabelle.
--15.07.2019: pjan1603 (SPEC0041902): in_kunde_id field added based on the belos_adresse_empfaenger_id column
--                                    werk_id field added based on the belos_adresse_absender_num_id column

(
mandant_id
,in_kunde_id
,werk_id
,belos_vorgang_id
,rundlauf_transport_fg
,tour_id
,vol_stauraum
,wup_id
,belos_adresse_absender_num_id
,verrechfall_id
,betrag_kosten


)
AS
   SELECT

   v01.mandant_id, v04.in_kunde_id, v05.werk_id, v01.belos_vorgang_id, v01.rundlauf_transport_fg, v01.tour_id, v01.vol_stauraum, v01.wup_id, v01.belos_adresse_absender_num_id, v03.verrechfall_id, v03.betrag_kosten


   FROM dbp_view.v_belos_vorgang_1 v01

   JOIN dbp_view.v_verrechfall_1 v02
   ON     v01. mandant_id = v02. mandant_id
   AND  v01.belos_vorgang_id = v02.belos_vorgang_id

   JOIN dbp_view.v_verrechfall_kosten_1 v03
   ON     v02. mandant_id = v03. mandant_id
   AND  v02.verrechfall_id = v03.verrechfall_id

   JOIN dbp_msi_view_flw.mv_l_in_kunde_1 v04
   ON    v04.kunde_nr = v01.belos_adresse_empfaenger_id
   AND   v04.mandant_id = v01.mandant_id

   JOIN dbp_msi_view_flw.mv_l_in_werk_1 v05
   ON    v05.werk_nr = v01.belos_adresse_absender_num_id
   AND   v05.mandant_id = v01.mandant_id;