defmodule AuthExWeb.ImageView do
  use AuthExWeb, :view
  alias AuthExWeb.ImageView

  def render("index.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{id: image.id,
      title: image.title,
      url: image.url}
  end
end
