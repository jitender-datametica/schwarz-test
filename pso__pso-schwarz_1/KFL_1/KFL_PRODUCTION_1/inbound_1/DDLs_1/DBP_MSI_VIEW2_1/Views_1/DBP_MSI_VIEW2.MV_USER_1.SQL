CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_USER_1
(
USER_ID
)
AS
-- AP0129958/SPEC0180042 Neuanlage im Zuge Zusammenlegung Security mit AIS_INT / ssch1303 30.01.2023
SELECT
v01.user_id

FROM dbp_security.gruppe_user_zu_1 v01
GROUP BY v01.user_id;