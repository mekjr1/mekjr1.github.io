require 'spec_helper'

RSpec.describe 'Responsive Design Implementation' do
  describe 'Viewport Configuration' do
    it 'includes viewport meta tag in head' do
      head_content = File.read('_includes/head.html')
      expect(head_content).to include('name="viewport"')
      expect(head_content).to include('width=device-width')
      expect(head_content).to include('initial-scale=1.0')
    end

    it 'includes HandheldFriendly meta tag' do
      head_content = File.read('_includes/head.html')
      expect(head_content).to include('name="HandheldFriendly"')
    end

    it 'includes MobileOptimized meta tag' do
      head_content = File.read('_includes/head.html')
      expect(head_content).to include('name="MobileOptimized"')
    end
  end

  describe 'Responsive Sass Styles' do
    let(:custom_scss) { File.read('_sass/custom.scss') }
    let(:navigation_scss) { File.read('_sass/_navigation.scss') }

    it 'defines mobile breakpoint variables' do
      expect(custom_scss).to include('$mobile:')
      expect(custom_scss).to include('$tablet:')
      expect(custom_scss).to include('$desktop:')
    end

    it 'includes mobile media queries for homepage hero' do
      expect(custom_scss).to include('@media (max-width: $tablet)')
      expect(custom_scss).to include('.page__hero--overlay')
    end

    it 'includes responsive styles for feature rows' do
      expect(custom_scss).to include('.feature__item')
      expect(custom_scss).to match(/@media.*max-width.*\$tablet/)
    end

    it 'includes responsive styles for writing hub' do
      expect(custom_scss).to include('.writing-hub')
      expect(custom_scss).to include('.writing-nav')
      expect(custom_scss).to match(/writing-grid.*grid-template-columns.*1fr/m)
    end

    it 'includes responsive styles for project grid' do
      expect(custom_scss).to include('.grid__wrapper')
      expect(custom_scss).to match(/grid-template-columns.*1fr/m)
    end

    it 'includes responsive navigation styles' do
      expect(navigation_scss).to include('.greedy-nav')
      expect(navigation_scss).to include('.navicon')
      expect(navigation_scss).to match(/@media.*max-width.*768px/)
    end

    it 'includes hamburger menu animation' do
      expect(navigation_scss).to include('button.close')
      expect(navigation_scss).to include('transform: rotate')
    end

    it 'includes responsive typography adjustments' do
      expect(custom_scss).to include('.page__content')
      expect(custom_scss).to match(/h1.*font-size.*\$type-size/m)
    end

    it 'includes responsive button styles' do
      expect(custom_scss).to include('.btn')
      expect(custom_scss).to match(/@media.*max-width.*\$mobile/)
    end

    it 'includes responsive image styles' do
      expect(custom_scss).to match(/img.*max-width.*100%/m)
    end

    it 'includes responsive table styles' do
      expect(custom_scss).to include('table')
      expect(custom_scss).to include('overflow-x: auto')
    end
  end

  describe 'Homepage Responsive Elements' do
    let(:homepage) { File.read('index.md') }

    it 'uses splash layout for responsive hero' do
      expect(homepage).to include('layout: splash')
    end

    it 'includes feature rows that will stack on mobile' do
      expect(homepage).to include('feature_row_services')
      expect(homepage).to include('feature_row_work')
      expect(homepage).to include('feature_row_writing')
    end

    it 'includes grid layout for "What I Do" section' do
      expect(homepage).to include('display: grid')
      expect(homepage).to include('grid-template-columns')
    end

    it 'includes CTA buttons with flex layout' do
      expect(homepage).to include('display: flex')
      expect(homepage).to include('btn--primary')
      expect(homepage).to include('btn--inverse')
    end
  end

  describe 'Writing Hub Responsive Elements' do
    let(:writing_page) { File.read('_pages/writing.md') }

    it 'includes writing hub container' do
      expect(writing_page).to include('class="writing-hub"')
    end

    it 'includes responsive navigation tabs' do
      expect(writing_page).to include('class="writing-nav"')
      expect(writing_page).to include('writing-nav-link')
    end

    it 'includes writing grid for cards' do
      expect(writing_page).to include('class="writing-grid"')
    end

    it 'includes JavaScript for tab switching' do
      expect(writing_page).to include('<script>')
      expect(writing_page).to include('addEventListener')
    end
  end

  describe 'Navigation Responsive Behavior' do
    let(:masthead) { File.read('_includes/masthead.html') }

    it 'includes hamburger button' do
      expect(masthead).to include('<button>')
      expect(masthead).to include('navicon')
    end

    it 'includes visible-links list' do
      expect(masthead).to include('class="visible-links"')
    end

    it 'includes hidden-links list for overflow' do
      expect(masthead).to include('class="hidden-links hidden"')
    end

    it 'uses greedy-nav class for responsive behavior' do
      expect(masthead).to include('class="greedy-nav"')
    end
  end

  describe 'Responsive Grid Layouts' do
    it 'project grid uses responsive columns' do
      custom_scss = File.read('_sass/custom.scss')
      expect(custom_scss).to match(/\.grid__wrapper.*grid-template-columns.*minmax/m)
    end

    it 'writing grid adapts to mobile' do
      custom_scss = File.read('_sass/custom.scss')
      expect(custom_scss).to match(/\.writing-grid.*@media.*grid-template-columns.*1fr/m)
    end
  end

  describe 'Touch Target Sizes' do
    let(:custom_scss) { File.read('_sass/custom.scss') }

    it 'ensures adequate button padding on mobile' do
      expect(custom_scss).to match(/\.btn.*padding.*0\.5rem.*1rem/m)
    end

    it 'ensures adequate link padding in navigation' do
      navigation_scss = File.read('_sass/_navigation.scss')
      expect(navigation_scss).to match(/padding.*1rem/m)
    end
  end

  describe 'Content Stacking on Mobile' do
    let(:custom_scss) { File.read('_sass/custom.scss') }

    it 'stacks feature rows vertically on mobile' do
      expect(custom_scss).to match(/\.feature__item.*@media.*width.*100%/m)
    end

    it 'stacks CTA buttons vertically on mobile' do
      expect(custom_scss).to match(/flex-direction.*column/m)
    end

    it 'makes sidebar full width on mobile' do
      expect(custom_scss).to match(/\.sidebar.*@media.*width.*100%/m)
    end
  end

  describe 'Typography Scaling' do
    let(:custom_scss) { File.read('_sass/custom.scss') }

    it 'scales headings on mobile' do
      expect(custom_scss).to match(/h1.*font-size.*\$type-size/m)
      expect(custom_scss).to match(/h2.*font-size.*\$type-size/m)
    end

    it 'adjusts body text size on mobile' do
      expect(custom_scss).to match(/p.*font-size.*0\.95rem/m)
    end

    it 'maintains readable line height' do
      expect(custom_scss).to match(/line-height.*1\.6/m)
    end
  end

  describe 'Image Responsiveness' do
    let(:custom_scss) { File.read('_sass/custom.scss') }

    it 'makes images responsive' do
      expect(custom_scss).to match(/img.*max-width.*100%/m)
      expect(custom_scss).to match(/height.*auto/m)
    end

    it 'handles project card images' do
      expect(custom_scss).to match(/\.archive__item-teaser.*height/m)
    end
  end

  describe 'Horizontal Scroll Prevention' do
    let(:custom_scss) { File.read('_sass/custom.scss') }

    it 'prevents table overflow with scrolling' do
      expect(custom_scss).to include('overflow-x: auto')
    end

    it 'ensures proper container padding' do
      expect(custom_scss).to match(/padding.*0\.5em/m)
    end
  end

  describe 'Build Success' do
    it 'builds site without errors' do
      expect(File.exist?('_site/index.html')).to be true
    end

    it 'generates CSS with responsive styles' do
      css_file = Dir.glob('_site/assets/css/main.css').first
      expect(css_file).not_to be_nil
      
      if css_file
        css_content = File.read(css_file)
        expect(css_content).to include('@media')
      end
    end
  end

  describe 'Test Page Creation' do
    it 'creates responsive design test page' do
      expect(File.exist?('test-responsive.html')).to be true
    end

    it 'test page includes viewport information' do
      test_page = File.read('test-responsive.html')
      expect(test_page).to include('viewport-info')
      expect(test_page).to include('window-width')
    end

    it 'test page includes breakpoint indicators' do
      test_page = File.read('test-responsive.html')
      expect(test_page).to include('mobile-indicator')
      expect(test_page).to include('tablet-indicator')
      expect(test_page).to include('desktop-indicator')
    end
  end
end
