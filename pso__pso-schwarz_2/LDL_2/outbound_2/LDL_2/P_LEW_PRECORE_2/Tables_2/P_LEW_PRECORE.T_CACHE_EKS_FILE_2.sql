/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  01.08.2022    Bialek, Aleksander       Initial Version Part of Liefertreue Dashboard RPA Alternative solution. AD WI: 356666 (Main WI:350713)
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_eks_file_2 (
ian STRING(100),
eks_nummer STRING(100),
land_verhandelt STRING(100),
einkaufer STRING(100),
int_lieferantennummer STRING(100),
bezeichnung_vertragspartner STRING(100),
artikelbez STRING(200),
belieferungsland STRING(100),
transportweg_kurz STRING(100),
transportweg_lang STRING(200),
file_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);