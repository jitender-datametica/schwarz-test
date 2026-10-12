CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_GRUPPE_USER_ZU
(
 GRUPPE_ID
,USER_ID
)
AS
-- AP0129958/SPEC0180042 Neuanlage im Zuge Zusammenlegung Security mit AIS_INT / ssch1303 30.01.2023
SELECT 
 v01.gruppe_id
,v01.user_id

FROM dbp_security.gruppe_user_zu v01;