CREATE TABLE [FF].[ExamenVraag] (
    [ExamenVraagID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ExamenVraagTypeID] INT           NOT NULL,
    [ExamenBlokID]      INT           NOT NULL,
    [Antwoord]          NVARCHAR (15) NULL,
    [Correct]           BIT           DEFAULT ((0)) NOT NULL,
    [Blanco]            BIT           DEFAULT ((0)) NOT NULL,
    [SoftDeleted]       BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([ExamenVraagID] ASC),
    CONSTRAINT [FK_ExamenVraag_ExamenBlok] FOREIGN KEY ([ExamenBlokID]) REFERENCES [FF].[ExamenBlok] ([ExamenBlokID]),
    CONSTRAINT [FK_ExamenVraag_ExamenVraagType] FOREIGN KEY ([ExamenVraagTypeID]) REFERENCES [FF].[ExamenVraagType] ([ExamenVraagTypeID])
);

