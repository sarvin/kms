class Admin::ChaptersController < Admin::BaseController
  def new
    @chapter = Chapter.new
    @chapter.build_public_navigation
  end

  def create
    @chapter = Chapter.new(chapter_params)

    if @chapter.save
      redirect_to [:admin, @chapter]
    else
      render 'new'
    end
  end

  def index
    @orphaned_chapters = Chapter.orphaned
    @adopted_chapters = Chapter.adopted
  end

  def edit
    @chapter = Chapter.find(params[:id])
  end

  def show
    @chapter = Chapter.includes(:users).find(params[:id])
  end

  def update
    @chapter = Chapter.find(params[:id])

    if @chapter.update(chapter_params)
      redirect_to [:admin, @chapter]
    else
      render 'edit'
    end
  end

  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy

    redirect_to admin_chapters_path
  end

  private
    def chapter_params
      params.require(:chapter).permit(:name, :state_id, public_navigation_attributes:[:id, :active])
    end
end
