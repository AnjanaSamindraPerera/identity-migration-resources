CREATE INDEX INDEX_UM_USERNAME_UM_TENANT_ID ON UM_USER(UM_USER_NAME, UM_TENANT_ID)
/

ALTER TABLE UM_TENANT ADD COLUMN UM_ORG_UUID VARCHAR(36) DEFAULT NULL
/
