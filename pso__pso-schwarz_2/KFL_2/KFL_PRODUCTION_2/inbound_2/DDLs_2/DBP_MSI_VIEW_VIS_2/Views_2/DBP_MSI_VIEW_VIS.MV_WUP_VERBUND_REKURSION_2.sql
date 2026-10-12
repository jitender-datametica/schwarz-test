CREATE OR REPLACE RECURSIVE VIEW DBP_MSI_VIEW_VIS.MV_WUP_VERBUND_REKURSION_2
(
mandant_id
, nb_id
, wup_id
, verteilgebiet_id
, counter
, wup_verbund
, wup_verbund_bez
)
AS
   -- ZUORDNUNG REKURSIV : Filialen mit gleichem Verteilgebiet pro Filiale
   -- rekursive Zuordnung der Filialen mit gleichem Verteilgebiet
   -- benoetigt mv_wup_verbund_helper_2
   -- 2012KW46 Initial

   SELECT DISTINCT -- BASIS : 1 Zeile pro Filiale
   basis.mandant_id, basis.nb_id, basis.wup_id, basis.verteilgebiet_id, 0::BYTEINT        AS counter, '  '::VARCHAR(512) AS wup_verbund -- Wichtig 2 Leerzeichen
   , '  '::VARCHAR(512) AS wup_verbund_bez -- Wichtig 2 Leerzeichen
   FROM dbp_msi_view_vis.mv_wup_verbund_helper_2  basis

   UNION ALL -- REKURSION : 1 Zeile pro Filiale in Helper/Detail auf Basis der Nummerierung
   SELECT
   rekursion.mandant_id, rekursion.nb_id, rekursion.wup_id, rekursion.verteilgebiet_id, rekursion.counter + 1       AS rek_count, wup_verbund || TRIM(detail.v_wup_id) || ' / ', wup_verbund_bez || TRIM(detail.v_wup_id) || ' ' || TRIM(detail.v_wup_standort) || ' / '
   FROM MV_WUP_VERBUND_REKURSION_2 rekursion

   JOIN dbp_msi_view_vis.mv_wup_verbund_helper_2  detail
   ON  rekursion.mandant_id = detail.mandant_id
   AND rekursion.wup_id = detail.wup_id
   AND rekursion.counter + 1 = detail.wup_count

   WHERE rek_count < 20 -- Anzahl Rekursionen
   ;