CREATE TABLE [FF].[Examen] (
    [ExamenID]              INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]           INT           NOT NULL,
    [ExamenTypeID]          NVARCHAR (15) NOT NULL,
    [DossierNummer]         NVARCHAR (15) NULL,
    [Geslaagd]              BIT           DEFAULT ((0)) NOT NULL,
    [GeslaagdNaDeliberatie] BIT           DEFAULT ((0)) NOT NULL,
    [ExtraPunt]             BIT           DEFAULT ((0)) NOT NULL,
    [Certificaat]           NVARCHAR (30) NULL,
    [AttestNummer]          NVARCHAR (30) NULL,
    [AttestNummerB]         NVARCHAR (30) NULL,
    [ExamenCentrumID]       NVARCHAR (15) NOT NULL,
    [SoftDeleted]           BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([ExamenID] ASC),
    CONSTRAINT [FK_Examen_ExamenCentrum] FOREIGN KEY ([ExamenCentrumID]) REFERENCES [FF].[ExamenCentrum] ([ExamenCentrumID]),
    CONSTRAINT [FK_Examen_ExamenType] FOREIGN KEY ([ExamenTypeID]) REFERENCES [FF].[ExamenType] ([ExamenTypeID]),
    CONSTRAINT [FK_Examen_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

