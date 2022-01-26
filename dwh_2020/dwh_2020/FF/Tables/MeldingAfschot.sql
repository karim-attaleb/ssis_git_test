CREATE TABLE [FF].[MeldingAfschot] (
    [IndieningID]          INT            NOT NULL,
    [AfschotPlanNummer]    NVARCHAR (15)  NULL,
    [MeldingAfschotDierID] INT            NULL,
    [JachtmethodeID]       NVARCHAR (15)  NULL,
    [WettelijkKaderID]     NVARCHAR (15)  NULL,
    [SoftDeleted]          BIT            CONSTRAINT [DF_MeldingAfschot_SoftDeleted] DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    [BestrijdingsActieID]  NVARCHAR (255) NULL,
    [WapenID]              NVARCHAR (255) NULL,
    [WapenKaliber]         NVARCHAR (6)   NULL,
    CONSTRAINT [PK_MeldingAfschot] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_MeldingAfschot_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_MeldingAfschot_MeldingAfschotDier] FOREIGN KEY ([MeldingAfschotDierID]) REFERENCES [FF].[MeldingAfschotDier] ([MeldingAfschotDierID])
);

