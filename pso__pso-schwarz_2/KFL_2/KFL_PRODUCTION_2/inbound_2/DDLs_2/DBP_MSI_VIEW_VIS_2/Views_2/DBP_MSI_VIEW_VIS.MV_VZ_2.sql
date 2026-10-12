CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VZ_2 as
   -- LOOKUP Verteilzentrum
   -- BASIS: wup_2 - Blackberry-Reporting
   -- 2011KW18 Initial

   SELECT
   v01.mandant_id, v01.vz_wup_id, v02.wup_standort                                  AS vz_standort, COALESCE(v02.dat_von, CAST('2000-01-01'AS DATE))  AS vz_dat_von, COALESCE(v02.dat_bis, CAST('9999-12-31' AS DATE)) AS vz_dat_bis

   FROM (
   SELECT mandant_id, vz_wup_id
   FROM dbp_view.v_vz_wg_wup_zu_per_2
   WHERE dat_bis = '9999-12-31'
   AND arthiertyp_id = -1
   AND wg_hierarchie_ebene_id = -1
   AND wg_hierarchie_id = -1
   GROUP BY mandant_id, vz_wup_id
   ) v01

   JOIN (
   SELECT mandant_id, wup_id, wup_standort, dat_von, dat_bis
   FROM dbp_view.v_wup_2
   WHERE nb_id = -111
   AND wup_typ_id = 2
   ) v02
   ON  v01.mandant_id = v02.mandant_id
   AND v01.vz_wup_id = v02.wup_id

   UNION ALL
   SELECT
   v02.mandant_id, v02.wup_id                                        AS vz_wup_id, v02.wup_standort                                  AS vz_standort, COALESCE(v02.dat_von, CAST('2000-01-01'AS DATE))  AS vz_dat_von, COALESCE(v02.dat_bis, CAST('9999-12-31' AS DATE)) AS vz_dat_bis
   FROM (
   SELECT mandant_id, wup_id, wup_standort, dat_von, dat_bis
   FROM dbp_view.v_wup_2
   WHERE wup_id = 0
   ) v02;