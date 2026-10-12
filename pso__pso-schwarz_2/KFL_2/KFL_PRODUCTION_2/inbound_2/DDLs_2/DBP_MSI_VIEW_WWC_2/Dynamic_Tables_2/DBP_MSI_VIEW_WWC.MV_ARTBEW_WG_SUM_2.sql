CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_ARTBEW_WG_SUM_2
-- AP0030398, SPEC0039495 srom0404 04.07.2018 - Payback ins WWC
(
WERKS
,mandant_id
,bewart_id
,nb_id
,dat
,MATKL
,MENGE
,VK_netto
,wrg_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
   SELECT v01.wup_id              AS WERKS, v01.mandant_id, v01.bewart_id, v01.nb_id, v01.dat, v01.wg_id               AS MATKL, v01.menge               AS MENGE            -- auf MSEG.MENGE mappen
   , v01.umsatz_netto        AS VK_netto         -- auf VK_2 Netto mappen
   , v02.default_wrg         AS wrg_id
   FROM dbp_view.v_artbew_wg_sum_2 v01
   JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id;