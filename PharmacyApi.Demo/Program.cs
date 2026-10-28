var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/prescriptions/{id}", (int id) =>
{
    return Results.Ok(new
    {
        Id = id,
        DrugName = "Amoxicillin",
        Dosage = "500mg"
    });
});

app.MapGet("/health", () => Results.Ok("healthy"));

app.Run();