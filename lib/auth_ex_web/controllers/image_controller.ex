defmodule AuthExWeb.ImageController do
  use AuthExWeb, :controller
  use PhoenixSwagger

  alias AuthEx.Assets
  alias AuthEx.Assets.Image

  action_fallback AuthExWeb.FallbackController

  def index(conn, _params) do
    images = Assets.list_images()
    render(conn, "index.json", images: images)
  end

  def create(conn, %{"image" => image_params}) do
    with {:ok, %Image{} = image} <- Assets.create_image(image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", image_path(conn, :show, image))
      |> render("show.json", image: image)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Assets.get_image!(id)
    render(conn, "show.json", image: image)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Assets.get_image!(id)

    with {:ok, %Image{} = image} <- Assets.update_image(image, image_params) do
      render(conn, "show.json", image: image)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Assets.get_image!(id)
    with {:ok, %Image{}} <- Assets.delete_image(image) do
      send_resp(conn, :no_content, "")
    end
  end

  swagger_path :index do
    get "/api/images"
    summary "Images"
    consumes "application/json"
    produces "application/json"
    response 200, "OK", Schema.ref(:MainResponse)
    response 400, "Client error"
  end

  def swagger_definitions do
    %{
      MainResponse: swagger_schema do
        title "Images"
        description "Lorem images"
        properties do
          data (Schema.new do 
            properties do
              title :string
              url :integer
            end
          end)
        end
      end
    }
  end
end
