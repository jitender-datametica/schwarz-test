create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_KOSTENSTELLE_MO_SUM_2(
	MANDANT_ID,
	KJMO,
	KOSTENSTELLE_ID,
	ANZ_MO_ALTER_KOSTENSTELLE,
	ANZ_MO_ALTER_KOSTENSTELLE_FE_I,
	ANZ_MO_ALTER_KOSTENSTELLE_FE_II,
	ANZ_MO_ALTER_KOSTENSTELLE_FE_III,
	ANZ_MO_ALTER_KOSTENSTELLE_FE_IV,
	ANZ_MO_ALTER_KOSTENSTELLE_FE_V,
	ANZ_MO_ALTER_KOSTENSTELLE_FE_VI,
	ANZ_MO_ALTER_KOSTENSTELLE_MA,
	ANZ_MO_ALTER_KOSTENSTELLE_GENDER_FRAU,
	ANZ_MO_ALTER_KOSTENSTELLE_GENDER_MANN,
	ANZ_MO_ALTER_KOSTENSTELLE_BZG_00_03_MO,
	ANZ_MO_ALTER_KOSTENSTELLE_BZG_03_06_MO,
	ANZ_MO_ALTER_KOSTENSTELLE_BZG_06_12_MO,
	ANZ_MO_ALTER_KOSTENSTELLE_BZG_12_36_MO,
	ANZ_MO_ALTER_KOSTENSTELLE_BZG_36_PLUS_MO
) as
--12.06.2024 twie: SPEC0238380 neue View für Kostenstellenalter

SELECT 
    mandant_id
    ,kjmo
    ,kostenstelle_id
    ,anz_mo_alter_kostenstelle
    ,anz_mo_alter_kostenstelle_fe_i
    ,anz_mo_alter_kostenstelle_fe_ii
    ,anz_mo_alter_kostenstelle_fe_iii
    ,anz_mo_alter_kostenstelle_fe_iv
    ,anz_mo_alter_kostenstelle_fe_v
    ,anz_mo_alter_kostenstelle_fe_vi
    ,anz_mo_alter_kostenstelle_ma
    ,anz_mo_alter_kostenstelle_gender_frau
    ,anz_mo_alter_kostenstelle_gender_mann
    ,anz_mo_alter_kostenstelle_bzg_00_03_mo
    ,anz_mo_alter_kostenstelle_bzg_03_06_mo
    ,anz_mo_alter_kostenstelle_bzg_06_12_mo
    ,anz_mo_alter_kostenstelle_bzg_12_36_mo
    ,anz_mo_alter_kostenstelle_bzg_36_plus_mo

FROM DBP_MSI_V_VIEW.V_KOSTENSTELLE_MO_SUM_2;