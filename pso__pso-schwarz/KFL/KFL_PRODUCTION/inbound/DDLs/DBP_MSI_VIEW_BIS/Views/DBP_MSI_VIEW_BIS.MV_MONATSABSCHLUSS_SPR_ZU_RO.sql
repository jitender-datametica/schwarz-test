CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MONATSABSCHLUSS_SPR_ZU_RO as
         SELECT

         v01.kj_ker_mo_id AS kjmo_abschluss,
         TRIM(v03.mo_bez) || ' ' || TRIM(v02.kj)::VARCHAR(20) AS mo_bez_lang

         FROM
         (
         SELECT
         MAX(kj_ker_mo_id) AS kj_ker_mo_id
         FROM dbp_view.v_l_buchungsstatus_ker v01
         WHERE dat_buchungs_schluss < CURRENT_DATE - 1
         ) v01
         INNER JOIN dbp_view.v_monat v02
         ON v01.kj_ker_mo_id = v02.kjmo
         INNER JOIN dbp_view.v_monat_spr_zu  v03
         ON v02.mo_kj = v03.mo_id
         AND v03.spr_id = 95
;