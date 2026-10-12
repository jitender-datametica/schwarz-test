CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LAND as
   -- LOOKUP/ZUORDNUNG Laender/Land/Mandant
   -- 2011KW37 REview
   -- 2013KW28 ueberfluessige Where-Bedingung (mandant_id <> 4) entfernt
   -- 2019.0520 ssch0611 : Erweiterung Moldau (+ weitere)

   SELECT
   CASE
   WHEN v01.mandant_id::BYTEINT = 1 THEN mandant_sort_id + 1
   ELSE mandant_sort_id + 2
   END::BYTEINT AS land_sort_id, v01.mandant_id::BYTEINT  AS land_id, v01.mandant_id::BYTEINT  AS mandant_id
   FROM dbp_view.v_mandant v01

   UNION ALL
   SELECT -- INT Knoten
   1::BYTEINT, -1::BYTEINT, v02.mandant_id::BYTEINT
   FROM dbp_view.v_mandant v02

   UNION ALL
   SELECT -- Ausland Knoten
   3::BYTEINT, -2::BYTEINT, v03.mandant_id::BYTEINT
   FROM dbp_view.v_mandant v03
   WHERE v03.mandant_id NOT IN (1)
;