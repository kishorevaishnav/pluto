defmodule Pluto.UploadController do
  use Pluto.Web, :controller

  alias Pluto.Upload

  def index(conn, params) do
    uploads = Repo.all(from u in Upload,
                       where: u.type == ^params["type"],
                       where: u.type_id == ^params["type_id"])
    render(conn, "index.json", uploads: uploads)
  end

  def create(conn, %{"type" => type, "type_id" => type_id, "upload" => upload_params}) do
    changeset = Upload.changeset(%Upload{}, Map.put(Map.put(upload_params, "type_id", type_id), "type", type))

    case Repo.insert(changeset) do
      {:ok, upload} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", upload_path(conn, :show, :type, :type_id, upload))
        |> render("show.json", upload: upload)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, params) do
    upload = Repo.one(from u in Upload,
                       where: u.type == ^params["type"],
                       where: u.type_id == ^params["type_id"],
                       where: u.id == ^params["id"])
    render(conn, "show.json", upload: upload)
  end

  def update(conn, %{"id" => id, "type" => type, "type_id" => type_id, "upload" => upload_params}) do
    upload = Repo.one(from u in Upload,
                       where: u.type == ^type,
                       where: u.type_id == ^type_id,
                       where: u.id == ^id)
    changeset = Upload.changeset(upload, upload_params)

    case Repo.update(changeset) do
      {:ok, upload} ->
        render(conn, "show.json", upload: upload)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, params) do
    upload = Repo.one(from u in Upload,
                       where: u.type == ^params["type"],
                       where: u.type_id == ^params["type_id"],
                       where: u.id == ^params["id"])

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(upload)

    send_resp(conn, :no_content, "")
  end
end
