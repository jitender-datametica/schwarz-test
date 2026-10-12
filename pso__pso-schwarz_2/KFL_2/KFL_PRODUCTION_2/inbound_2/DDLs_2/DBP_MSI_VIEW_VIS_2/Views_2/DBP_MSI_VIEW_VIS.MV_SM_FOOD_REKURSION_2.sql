CREATE OR REPLACE RECURSIVE VIEW DBP_MSI_VIEW_VIS.MV_SM_FOOD_REKURSION_2 (
mandant_id
, nb_id
, wup_id
, sst_food_id
, counter
, wg_food
, wg_food_bez
)
AS
   -- ZUORDNUNG REKURSIV : Sortimentkategorie/Profilierungswarengruppen Food SB pro Filiale
   -- rekursive Zuordnung von Profilierungs-WG mit abw. SM_2 zu SM_2/SST Food
   -- benoetigt mv_sm_food_helper_2
   -- 2012KW46 Initial (Q2)

   SELECT DISTINCT -- BASIS : 1 Zeile pro Filiale
   basis.mandant_id, basis.nb_id, basis.wup_id, basis.sst_food_id, 0::BYTEINT        AS counter, '  '::VARCHAR(512)  AS wg_food -- Wichtig 2 Leerzeichen
   , '  '::VARCHAR(512)  AS wg_food_bez -- Wichtig 2 Leerzeichen
   FROM dbp_msi_view_vis.mv_sm_food_helper_2  basis

   UNION ALL -- REKURSION : 1 Zeile pro WG in Helper/Detail auf Basis von WG Nummerierung
   SELECT
   rekursion.mandant_id, rekursion.nb_id, rekursion.wup_id, rekursion.sst_food_id, rekursion.counter + 1       AS rek_count, wg_food || detail.wg || ', ', wg_food_bez || detail.wg_bez || ', '
   FROM MV_SM_FOOD_REKURSION_2 rekursion

   JOIN dbp_msi_view_vis.mv_sm_food_helper_2  detail
   ON  rekursion.mandant_id = detail.mandant_id
   AND rekursion.wup_id = detail.wup_id
   AND rekursion.counter + 1 = detail.wg_count

   WHERE rek_count < 25 -- Anzahl Rekursionen
   ;