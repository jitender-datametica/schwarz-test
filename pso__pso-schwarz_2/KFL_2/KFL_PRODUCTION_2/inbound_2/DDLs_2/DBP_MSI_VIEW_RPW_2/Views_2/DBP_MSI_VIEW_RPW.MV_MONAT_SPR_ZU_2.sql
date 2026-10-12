CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_MONAT_SPR_ZU_2
 (
 mo_gj
 ,mo_kj
 ,spr_id
 ,mo_bez
 ,kjmo
 ,kj
 ,gj
 ,gjmo
 ,mo_bez_lang
 ,system_id
 )
 AS
    SELECT
    monat.mo_gj,
    text.mo_id,
    text.spr_id,
    text.mo_bez,
    monat.kjmo,
    monat.kj,
    monat.gj,
    gjmo,
    trim(text.mo_bez)|| ' ' ||trim(monat.kj),
    7
    FROM dbp_view.v_monat_spr_zu_2 text
    INNER JOIN dbp_view.v_monat_2 monat_2
    ON text.mo_id=monat.mo_kj
    AND spr_id=22
    AND kjmo >=200501
    AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);