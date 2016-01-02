module ChaptersHelper
	def sort_chapters_by_state chapters
		chapter_sort_hash = {}

		chapters.each do |chapter|
			if chapter.state
				chapter_sort_hash[chapter.state.name] = chapter
			else
				chapter_sort_hash[chapter.name] = chapter
			end
		end

		sorted_chapters = []
		chapter_sort_hash.sort_by{|key, chapter| key.downcase}.each do |key, chapter|
			sorted_chapters.push(chapter)
		end

		return sorted_chapters
	end
end
