CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_L_REKLAMATIONSGRUND_2 AS
--10.07.2023 snik: SPEC0202038 L_REKLAMATIONSGRUND_2
   SELECT
    v01.mandant_id
   ,v01.reklamationsgrund_id
   FROM dbp_view.v_l_reklamationsgrund_2 v01
;