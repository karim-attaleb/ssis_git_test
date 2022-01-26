CREATE TABLE [DR].[Dossier] (
    [IndieningID]           INT            NOT NULL,
    [DossierTypeVersieID]   NVARCHAR (15)  NOT NULL,
    [DossierStatusID]       NVARCHAR (15)  NOT NULL,
    [DossierNummer]         NVARCHAR (200) NULL,
    [VolgNummer]            INT            CONSTRAINT [DF_Dossier_VolgNummer] DEFAULT ((0)) NOT NULL,
    [AangemaaktDatum]       DATETIME       NOT NULL,
    [OntvangstDatum]        DATETIME       NULL,
    [AfTeHandelenVoorDatum] DATETIME       NULL,
    [UitDatum]              DATETIME       NULL,
    [OrganisatieThemaID]    NVARCHAR (15)  NULL,
    [WerkThemaID]           NVARCHAR (15)  NULL,
    [SoftDeleted]           BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Dossier] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_Dossier_DossierStatus] FOREIGN KEY ([DossierStatusID]) REFERENCES [DR].[DossierStatus] ([DossierStatusID]),
    CONSTRAINT [FK_Dossier_DossierTypeVersie] FOREIGN KEY ([DossierTypeVersieID]) REFERENCES [DR].[DossierTypeVersie] ([DossierTypeVersieID]),
    CONSTRAINT [FK_Dossier_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_Dossier_OrganisatieThema] FOREIGN KEY ([OrganisatieThemaID]) REFERENCES [DR].[OrganisatieThema] ([OrganisatieThemaID]),
    CONSTRAINT [FK_Dossier_WerkThema] FOREIGN KEY ([WerkThemaID]) REFERENCES [DR].[WerkThema] ([WerkThemaID])
);


GO
CREATE NONCLUSTERED INDEX [IXFK_Dossier_DossierStatus]
    ON [DR].[Dossier]([DossierStatusID] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IXFK_Dossier_DossierType]
    ON [DR].[Dossier]([DossierTypeVersieID] ASC)
    ON [Indexes];

