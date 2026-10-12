create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_TS_LIN_GF_ORG_EBENE_ZU_SK_1(
	USER_ID,
	HR_OBJEKT_EBENE2_ID,
	HR_OBJEKT_EBENE3_ID,
	HR_OBJEKT_EBENE4_ID,
	EINSTIEGSEBENE,
	MANDANT_ID,
	KJMO,
	HR_OBJEKT_EBENE11_ID,
	HR_OBJEKT_EBENE_GF_01,
	HR_OBJEKT_EBENE_GF_02,
	HR_OBJEKT_EBENE_GF_03,
	HR_OBJEKT_EBENE_GF_01_BEZ,
	HR_OBJEKT_EBENE_GF_02_BEZ,
	HR_OBJEKT_EBENE_GF_03_BEZ
) as
SELECT
    distinct v01.USER_ID,
    v01.HR_OBJEKT_EBENE2_ID,
    v01.HR_OBJEKT_EBENE3_ID,
    v01.HR_OBJEKT_EBENE4_ID,
    case
        when v01.HR_OBJEKT_EBENE2_ID is not null then 2
        when v01.HR_OBJEKT_EBENE3_ID is not null then 3
        when v01.HR_OBJEKT_EBENE4_ID is not null then 4
    end as Einstiegsebene,
    v02.mandant_id,
    v02.kjmo,
    v02.hr_objekt_ebene11_id,
    case
        when Einstiegsebene = 2 then v01.HR_OBJEKT_EBENE2_ID
        when Einstiegsebene = 3 then v01.HR_OBJEKT_EBENE3_ID
        when Einstiegsebene = 4 then v01.HR_OBJEKT_EBENE4_ID
    end as HR_OBJEKT_EBENE_GF_01,
    case
        when Einstiegsebene = 2 then v02.HR_OBJEKT_EBENE3_ID
        when Einstiegsebene = 3 then v02.HR_OBJEKT_EBENE4_ID
        when Einstiegsebene = 4 then v02.HR_OBJEKT_EBENE5_ID
    end as HR_OBJEKT_EBENE_GF_02,
    case
        when Einstiegsebene = 2 then v02.HR_OBJEKT_EBENE4_ID
        when Einstiegsebene = 3 then v02.HR_OBJEKT_EBENE5_ID
        when Einstiegsebene = 4 then v02.HR_OBJEKT_EBENE6_ID
    end as HR_OBJEKT_EBENE_GF_03,
    case
        when Einstiegsebene = 2 then v02.HR_OBJEKT_EBENE2_BEZ
        when Einstiegsebene = 3 then v02.HR_OBJEKT_EBENE3_BEZ
        when Einstiegsebene = 4 then v02.HR_OBJEKT_EBENE4_BEZ
    end as HR_OBJEKT_EBENE_GF_01_BEZ,
    case
        when Einstiegsebene = 2 then v02.HR_OBJEKT_EBENE3_BEZ
        when Einstiegsebene = 3 then v02.HR_OBJEKT_EBENE4_BEZ
        when Einstiegsebene = 4 then v02.HR_OBJEKT_EBENE5_BEZ
    end as HR_OBJEKT_EBENE_GF_02_BEZ,
    case
        when Einstiegsebene = 2 then v02.HR_OBJEKT_EBENE4_BEZ
        when Einstiegsebene = 3 then v02.HR_OBJEKT_EBENE5_BEZ
        when Einstiegsebene = 4 then v02.HR_OBJEKT_EBENE6_BEZ
    end as HR_OBJEKT_EBENE_GF_03_BEZ
FROM
    DBP_MSI_V_VIEW.V_TS_LIN_GF_ORG_EBENE_ZU_1 v01
    JOIN dbp_view.v_org_einheit_hierarchie_1 v02 on (
        case
            when v01.HR_OBJEKT_EBENE2_ID is not null then v01.HR_OBJEKT_EBENE2_ID
            when v01.HR_OBJEKT_EBENE3_ID is not null then v01.HR_OBJEKT_EBENE3_ID
            when v01.HR_OBJEKT_EBENE4_ID is not null then v01.HR_OBJEKT_EBENE4_ID
        end
    ) = (
        case
            when v01.HR_OBJEKT_EBENE2_ID is not null then v02.HR_OBJEKT_EBENE2_ID
            when v01.HR_OBJEKT_EBENE3_ID is not null then v02.HR_OBJEKT_EBENE3_ID
            when v01.HR_OBJEKT_EBENE4_ID is not null then v02.HR_OBJEKT_EBENE4_ID
        end
    )
    INNER JOIN dbp_view.v_monat_1 v03 ON v02.kjmo = v03.kjmo
where
    v03.akt_mo BETWEEN -3 AND 0
    and v02.spr_id = 108;