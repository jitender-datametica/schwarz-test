CREATE
OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_POSTEN_KZ_SAP_SPR_ZU_2 as
SELECT
   mandant_id,
   posten_kz_sap,
   MAX(
      CASE
         WHEN (
            spr_id = 22
            AND NOT posten_kz_sap = ''
         ) THEN posten_bez_sap
         WHEN (
            spr_id = 22
            AND posten_kz_sap = ''
         ) THEN 'Sortimentsartikel'
      END
   ) AS posten_bez_sap,
   MAX(
      CASE
         WHEN (
            spr_id = 22
            AND NOT posten_kz_sap = ''
         ) THEN posten_bez_sap
         WHEN (
            spr_id = 22
            AND posten_kz_sap = ''
         ) THEN 'Sortimentsartikel'
      END
   ) AS posten_bez_sap_de,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 124
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 124
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_cz -- CZ
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 108
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 108
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_sk -- SK
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 65
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 65
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_hr -- HR
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 90
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 90
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_pl -- PL
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 95
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 95
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_ro -- RO
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 18
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 18
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_bg -- BG
FROM
   dbp_view.v_posten_kz_sap_spr_zu_2
GROUP BY
   mandant_id,
   posten_kz_sap
UNION
ALL
SELECT
   mandant_id,
   '' as posten_kz_sap,
   'Sortiment' as posten_bez_sap,
   'Sortiment' as posten_bez_sap_de,
   'výber' as posten_bez_sap_cz,
   'výber' as posten_bez_sap_sk,
   'asortiman' as posten_bez_sap_hr,
   'asortyment' as posten_bez_sap_pl,
   'sortiment' as posten_bez_sap_ro,
   'асортимент' as posten_bez_sap_bg
from
   dbp_view.v_mandant_2;