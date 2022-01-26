CREATE TABLE [FF].[VoorlopigArrondissementCommissaris] (
    [VoorlopigArrondissementCommissarisID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Naam]                                 NVARCHAR (50)  NOT NULL,
    [Voornaam]                             NVARCHAR (50)  NOT NULL,
    [ProvincieID]                          NVARCHAR (15)  NOT NULL,
    [RijksregisterNummer]                  NVARCHAR (50)  NOT NULL,
    [Beschrijving]                         NVARCHAR (200) NULL,
    [Commentaar]                           NVARCHAR (800) NULL,
    [SoftDeleted]                          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_VoorlopigArrondissementCommissaris] PRIMARY KEY CLUSTERED ([VoorlopigArrondissementCommissarisID] ASC)
);

